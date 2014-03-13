module Tenon
  module CanHaveComments
    def self.included(mod)
      mod.extend(ClassMethods)
    end

    module ClassMethods
      def can_have_comments
        self.send(:has_many, :comments, :as => :commentable, :dependent => :destroy)
        self.send(:has_many, :subscribers, :class_name => 'CommentSubscriber', :as => :commentable, :dependent => :destroy)
      end
    end
  end
end

ActiveRecord::Base.send(:include, Tenon::CanHaveComments)
