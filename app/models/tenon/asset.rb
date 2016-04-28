module Tenon
  class Asset < ActiveRecord::Base
    attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :duplicate

    # Scopes
    default_scope -> { order('created_at DESC').includes(:item_assets) }

    # Associations
    has_many :item_assets

    # Attachment
    has_attached_file :attachment, styles: Proc.new { |clip|
      Tenon::AssetStyleGenerator.generate(clip.instance)
    }

    validates_attachment_presence :attachment
    do_not_validate_attachment_file_type :attachment
    before_attachment_post_process :prevent_pdf_thumbnail

    # Filters
    before_destroy :check_attached_items

    def self.with_type(type)
      if %w(images).include?(type)
        where('attachment_content_type LIKE ?', "%#{type.singularize}%")
      else
        documents
      end
    end

    def self.documents
      where('attachment_content_type NOT LIKE ?', '%image%')
    end

    def is_image?
      attachment_content_type =~ /image/
    end

    def dimensions(style = :original)
      attach = style.to_sym == :original ? attachment : attachment.styles[style]
      file = Paperclip.io_adapters.for(attach)
      Paperclip::Geometry.from_file(file).to_s.split('x')
    end

    def cropping?
      crop_x.present?
    end

    private

    def check_attached_items
      unless item_assets.count == 0
        errors.add(:base, t('tenon.assets.in_use'))
        return false
      end
    end

    def prevent_pdf_thumbnail
      return false unless attachment_content_type.index('image')
    end
  end
end
