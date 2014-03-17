# This is for controllers that have simple forms that just use a modal
module Tenon
  class SimpleResourcesController < Tenon::ResourcesController
    def index
      self.resource = klass.new
      super
    end

    def edit
      render partial: 'form', locals: { singular_name => resource }
    end
  end
end
