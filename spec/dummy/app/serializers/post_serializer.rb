class PostSerializer < Tenon::BaseSerializer #:nodoc:
  attributes :title, :featured, :formatted_publish_at
end
