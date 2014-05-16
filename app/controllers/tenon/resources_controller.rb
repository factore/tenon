module Tenon
  class ResourcesController < Tenon::BaseController
    respond_to :html, :json, :js

    def initialize(*args)
      self.class.load_and_authorize_resource(send(:load_options))
      super(*args)
    end

    def index
      params[:page] = 1 if params[:page].to_i == 0
      respond_to do |format|
        format.html
        format.json do
          self.collection = klass.all
          self.collection = collection.where(search_args) if params[:q]
          self.collection = collection.paginate(per_page: 20, page: params[:page])
          self.collection = Tenon::PaginatingDecorator.decorate(collection)
        end
      end
    end

    def new
      if params[:version] && resource.respond_to?(:revert)
        @item_version = Tenon::ItemVersion.find(params[:version])
        resource.revert(@item_version)
      end
      respond_with(resource)
    end

    def edit
      if params[:version] && resource.respond_to?(:revert)
        @item_version = Tenon::ItemVersion.find(params[:version])
        resource.revert(@item_version)
      end
      respond_with(resource)
    end

    def update
      if resource.update_attributes(resource_params)
        save_item_version if resource.respond_to?(:versions)
        flash[:notice] = "#{human_name} saved successfully." unless request.xhr?
      end

      self.resource = resource.decorate
      respond_with(resource.decorate, location: polymorphic_index_path)
    end

    def create
      self.resource = klass.new(resource_params).decorate
      if resource.save && !request.xhr?
        flash[:notice] = "#{human_name} saved successfully."
        save_item_version if resource.respond_to?(:versions)
      end
      respond_with(resource.decorate, location: polymorphic_index_path, status: 201)
    end

    def destroy
      if resource.destroy
        respond_with(resource, location: polymorphic_index_path)
      else
        respond_to do |format|
          format.json do
            render json: { errors: resource.errors }
          end
        end
      end
    end

    def reorder
      self.collection = klass.reorder!(params['item_list'])
      respond_with(collection, location: polymorphic_index_path)
    end

    private

    def save_item_version
      item_version = resource.versions.build
      item_version.attrs = resource_params
      item_version.user = current_user
      item_version.created_at = resource.updated_at
      item_version.save_type = 'post-save'
      item_version.title = 'Post-Save'
      item_version.save
    end

    def resource
      instance_variable_get("@#{singular_name}").decorate
    end
    helper_method :resource

    def klass
      name = singular_name.classify
      name.safe_constantize || "Tenon::#{name}".constantize
    end

    def resource=(val)
      instance_variable_set("@#{singular_name}", val)
    end

    def collection
      instance_variable_get("@#{plural_name}".to_sym)
    end

    def collection=(val)
      instance_variable_set("@#{plural_name}", val)
    end

    def singular_name
      @singular_name ||= plural_name.singularize
    end

    def plural_name
      @plural_name ||= params[:controller].split('/').last
    end

    def human_name
      singular_name.titleize
    end

    def polymorphic_index_path
      polymorphic_path([klass])
    end

    def load_options
      { except: [:index, :create] }
    end

    def search_args
      ["#{klass.table_name}.title ILIKE ?", "%#{params[:q]}%"]
    end

    def resource_params
      fail 'Define strong paramaters in controller method resource_params'
    end

    def sidebar
      partial = "tenon/#{controller_name.pluralize}/sidebar"
      partial if File.exist? File.join(Rails.root, 'app', 'views', partial)
    end

    helper_method :sidebar
  end
end
