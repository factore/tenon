module Tenon
  class ResourcesController < Tenon::BaseController
    respond_to :html, :json, :js

    def initialize(*args)
      self.class.load_and_authorize_resource(send(:load_options))
      super(*args)
    end

    def index
      authorize!(:index, klass)
      params[:page] = 1 if params[:page].to_i == 0
      respond_to do |format|
        format.html
        format.json do
          self.collection = filterer.filter
          self.collection = collection.paginate(per_page: 5, page: params[:page])
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
      authorize!(:publish, resource)
      if resource.update_attributes(resource_params)
        save_item_version if resource.respond_to?(:versions)
        flash[:notice] = "#{human_name} saved successfully." unless request.xhr?
      end

      self.resource = resource.decorate
      respond_to do |format|
        format.html { redirect_to after_update_path }
        format.json do
          render :partial => singular_name, :locals => {
            singular_name.to_sym => @post
          }
        end
      end
    end

    def create
      self.resource = klass.new(resource_params).decorate
      authorize!(:publish, resource)
      if resource.save && !request.xhr?
        flash[:notice] = "#{human_name} saved successfully."
        save_item_version if resource.respond_to?(:versions)
      end
      respond_with(resource.decorate, location: after_create_path, status: (201 if resource.valid?))
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

    def after_create_path
      if Tenon.config.after_create_path == :edit && resource.valid?
        polymorphic_path([:edit, resource])
      else
        polymorphic_index_path
      end
    end

    def after_update_path
      after_create_path
    end

    def polymorphic_index_path
      polymorphic_path([klass])
    end

    def load_options
      { except: [:index, :create] }
    end

    def quick_search_fields
      ["#{klass.table_name}.title"]
    end

    def filterer
      Tenon::GenericFilterer.new(klass.all, params, quick_search_fields)
    end

    def resource_params
      fail 'Define strong paramaters in controller method resource_params'
    end
  end
end
