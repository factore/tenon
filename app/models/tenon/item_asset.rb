module Tenon
  class ItemAsset < Tenon::ApplicationRecord
    # Validations
    validates_presence_of :asset

    # Relationships
    belongs_to :asset
    belongs_to :item, polymorphic: true

    accepts_nested_attributes_for :asset

    after_save :reprocess_asset

    def reprocess_asset
      asset.reload.attachment.reprocess! if asset_id_changed?
    end
  end
end
