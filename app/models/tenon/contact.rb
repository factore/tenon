module Tenon
  class Contact < ActiveRecord::Base
    include Humanizer
    require_human_on :create, unless: :bypass_humanizer

    attr_accessor :subscribe, :controller, :bypass_humanizer, :page_id, :address
    # attr_accessor :address is for the honeypot

    # Validations
    validates_presence_of :name, :email, :content
    validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

    # Scopes
    default_scope { order('created_at DESC') }
    scope :read, -> { where(read: true) }
    scope :unread, -> { where(read: false) }
    scope :replied, -> { where(replied: true) }
    scope :unreplied, -> { where(replied: false) }

    def toggle_replied!
      self.replied = self.replied? ? false : true
      save
    end

    def toggle_read!
      self.read = self.read? ? false : true
      save
    end

    def pooh_in_the_honey?
      address.present?
    end

    # To send contact requests from a controller:
    # ContactMailer.contact_notification(@contact).deliver

    # To check the honeypot from a controller:
    # if @contact.pooh_in_the_honey?
    #   return false positive
    # elsif @contact.save
    #   return positive
    # else
    #   return errors
    # end
  end
end
