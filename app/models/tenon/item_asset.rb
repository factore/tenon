module Tenon
  class ItemAsset < ActiveRecord::Base
    # Validations
    validates_presence_of :asset
    validates_presence_of :item

    # Relationships
    belongs_to :asset
    belongs_to :item, :polymorphic => true

    accepts_nested_attributes_for :asset

    after_create :reprocess_asset

    def reprocess_asset
      asset.reload.attachment.reprocess!
    end
  end
end