class PostSerializer < Tenon::ApplicationSerializer #:nodoc:
  attributes :title, :featured, :formatted_publish_at
end
