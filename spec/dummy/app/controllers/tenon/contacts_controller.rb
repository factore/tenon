module Tenon
  class ContactsController < Tenon::ResourcesController
    before_filter :load_contact, only: [:toggle_read, :toggle_replied, :destroy]

    def toggle_read
      respond_to do |format|
        if @contact.toggle_read!
          format.json { render json: @contact.to_json }
          format.html do
            flash[:notice] = 'Comment flagged as read.'
            redirect_to contacts_path
          end
        else
          format.json { render status: 500, nothing: true }
          format.html do
            flash[:warning] = 'Error flagging contact as read.'
            redirect_to contacts_path
          end
        end
      end
    end

    def toggle_replied
      respond_to do |format|
        if @contact.toggle_replied!
          format.json { render json: @contact.to_json }
          format.html do
            flash[:notice] = 'Comment flagged as replied.'
            redirect_to contacts_path
          end
        else
          format.json { render status: 500, nothing: true }
          format.html do
            flash[:warning] = 'Error flagging contact as replied.'
            redirect_to contacts_path
          end
        end
      end
    end

    private

    def load_contact
      @contact = Contact.find(params[:id])
      authorize(@contact, :update)
    end

    def quick_search_fields
      %w(name email phone content user_ip).map { |field| "contacts.#{field}" }
    end
  end
end
