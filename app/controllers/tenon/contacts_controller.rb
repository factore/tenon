module Tenon
  class ContactsController < Tenon::ResourcesController
    before_filter :get_contact, only: [:approve, :unapprove, :destroy]

    def index
      respond_to do |format|
        format.html do
          @counts = {
            all: Tenon::Contact.count,
            read: Tenon::Contact.read.count,
            unread: Tenon::Contact.unread.count,
            replied: Tenon::Contact.replied.count,
            unreplied: Tenon::Contact.unreplied.count
          }
        end
        format.json do
          @contacts = Tenon::Contact.all
          @contacts = @contacts.where(search_args) if params[:q]
          if %w(read unread replied unreplied).include?(params[:type])
            @contacts = @contacts.send(params[:type])
          end
          @contacts = @contacts.paginate(per_page: 20, page: params[:page])
          @contacts = Tenon::PaginatingDecorator.decorate(@contacts)
        end
      end
    end

    def toggle_read
      respond_to do |format|
        if @contact.toggle_read!
          format.json { render json: @contact.to_json }
          format.html { flash[:notice] = 'Comment flagged as read.' and redirect_to contacts_path }
        else
          format.json { render status: 500, nothing: true }
          format.html { flash[:warning] = 'Error flagging contact as read.' and redirect_to contacts_path }
        end
      end
    end

    def toggle_reply
      respond_to do |format|
        if @contact.toggle_reply!
          format.json { render json: @contact.to_json }
          format.html { flash[:notice] = 'Comment flagged as replied.' and redirect_to contacts_path }
        else
          format.json { render status: 500, nothing: true }
          format.html { flash[:warning] = 'Error flagging contact as replied.' and redirect_to contacts_path }
        end
      end
    end

    private

    def get_contact
      @contact = Tenon::Contact.find(params[:id])
    end

    def search_args
      [
        'name ILIKE :q OR email ILIKE :q OR content ILIKE :q OR user_ip ILIKE :q',
        { q: "%#{params[:q]}%" }
      ]
    end
  end
end
