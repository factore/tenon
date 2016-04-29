class ItemVersionSerializer < Tenon::ApplicationSerializer
  attributes :id, :title, :user_email, :load_version_path, :formatted_date

  def load_version_path
    if object.item
      scope.polymorphic_path([:edit, object.item], version: object.id)
    else
      scope.new_polymorphic_path(object.item_type.constantize, version: object.id)
    end
  end

  def user_email
    object.user.email
  end

  def formatted_date
    object.created_at.strftime('%B %e, %Y at %-l:%M%p')
  end

  def default_attributes
    {}
  end
end
