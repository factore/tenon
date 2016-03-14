module Tenon
  class ResourcesController < BaseController
    wrap_parameters format: [:json]
    respond_to :html, :json, :js
    after_action :verify_authorized
    after_action :verify_policy_scoped,
      only: :index,
      if: -> { request.format.json? }

    def index
      authorize(klass)
      params[:page] = 1 if params[:page].to_i == 0
      respond_to do |format|
        format.html
        format.json do
          self.collection = filterer.filter
          self.collection = collection.paginate(per_page: 5, page: params[:page])
          self.collection = Tenon::PaginatingDecorator.decorate(collection)
          respond_with(
            collection,
            serializer: Tenon::PaginatingSerializer,
            each_serializer: ActiveModel::Serializer.serializer_for(klass.new),
            root: 'records'
          )
        end
      end
    end

    def new
      self.resource = klass.new
      authorize(resource)
      before_new
      if params[:version] && resource.respond_to?(:revert)
        @item_version = Tenon::ItemVersion.find(params[:version])
        resource.revert(@item_version)
      end

      respond_to do |format|
        format.html
      end
    end

    def edit
      self.resource = policy_scope(klass).find(params[:id])
      authorize(resource)
      before_edit
      if params[:version] && resource.respond_to?(:revert)
        @item_version = Tenon::ItemVersion.find(params[:version])
        resource.revert(@item_version)
      end

      respond_to do |format|
        format.html
      end
    end

    def update
      self.resource = policy_scope(klass).find(params[:id])
      authorize(resource)
      before_update
      if resource.update_attributes(resource_params)
        save_item_version if resource.respond_to?(:versions)
        flash[:notice] = "#{human_name} saved successfully." unless xhr_or_js?
      end
      self.resource = resource.decorate

      respond_to do |format|
        format.html do
          if resource.valid?
            redirect_to after_update_path
          else
            render action: :edit
          end
        end
        format.json do
          render(json: resource)
        end
      end
    end

    def create
      self.resource = klass.new(resource_params).decorate
      authorize(resource)
      before_create
      if resource.save
        flash[:notice] = "#{human_name} saved successfully." unless xhr_or_js?
        save_item_version if resource.respond_to?(:versions)
      end

      respond_to do |format|
        format.html do
          if resource.valid?
            redirect_to after_create_path
          else
            render action: :new
          end
        end
        format.json { render json: resource }
      end
    end

    def destroy
      self.resource = policy_scope(klass).find(params[:id])
      authorize(resource)
      before_destroy
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
      authorize(klass)
      self.collection = klass.reorder!(params['item_list'])
      respond_with(collection, location: polymorphic_index_path)
    end

    private

    # Serializer Setup Methods
    def default_serializer_options
      { root: 'record', scope: view_context }
    end

    # Override these to execute code after resources are loaded
    # but before saved/acted upon
    %w(new edit update create destroy reorder).each do |action|
      define_method("before_#{action}") { }
    end

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

    def quick_search_fields
      ["#{klass.table_name}.title"]
    end

    def filterer
      Tenon::GenericFilterer.new(
        policy_scope(klass),
        params,
        quick_search_fields
      )
    end

    def resource_params
      raise 'Define strong paramaters in controller method resource_params'
    end
  end
end
