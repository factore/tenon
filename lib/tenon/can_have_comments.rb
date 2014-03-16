module Tenon
  module CanHaveComments
    def self.included(mod)
      mod.extend(ClassMethods)
    end

    module ClassMethods
      def can_have_comments
        send(:has_many, :comments, as: :commentable, dependent: :destroy)
        send(:has_many, :subscribers, class_name: 'CommentSubscriber', as: :commentable, dependent: :destroy)
      end
    end
  end
end

ActiveRecord::Base.send(:include, Tenon::CanHaveComments)
