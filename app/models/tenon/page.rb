module Tenon
  class Page < ActiveRecord::Base
    # Scopes, Attrs, Etc.
    acts_as_nested_set
    has_history except: [:lft, :rgt, :parent_id, :depth],
                includes: [:content_tenon_content_rows]
    tenon_content :content
    default_scope { order('tenon_pages.lft, tenon_pages.list_order') }
    scope :published, -> { where('publish_at <= ?', Time.now) }
    scope :find_for_menu, -> { published.where('parent_id IS NULL AND show_in_menu = ?', true).includes(:subpages) }
    scope :top, -> { where(parent_id: nil) }

    # Relationships
    belongs_to :parent, class_name: 'Page', foreign_key: 'parent_id'
    has_many :subpages, -> { order 'list_order' }, class_name: 'Page', foreign_key: 'parent_id', dependent: :destroy

    # Validations
    before_validation :set_slug_and_path
    after_move :set_slug_and_path
    validates_presence_of :title
    validates_presence_of :slug, message: 'must exist in order to have a properly generated URL.'
    validates_uniqueness_of :slug, scope: :parent_id
    validate :path_is_not_route
    validate :parent_is_not_in_tree

    # Return siblings if subpages aren't available
    def subpages_for_menu
      if subpages.blank?
        siblings_for_menu
      else
        subpages.where(published: true, show_in_menu: true)
      end
    end

    def siblings_for_menu
      parent.subpages_for_menu if parent
    end

    def self.reorder!(list, parent_id)
      unless list.blank?
        pages = []

        # Move all the pages to the right parent_id first
        list.each_with_index do |id, order|
          pages << Page.find_by_id(id)
          pages[order].move_to_child_of(parent_id) if pages[order] && parent_id
        end

        # Then give them the ol shuffle
        first_page = pages[0]
        previous_page = first_page
        pages.each_with_index do |page, order|
          next if order == 0
          page = pages[order]
          page.move_to_right_of(previous_page)
          page.save
          previous_page = page
        end
      end
    end

    protected

    def path_is_not_route
      match = Rails.application.routes.recognize_path(path, method: :get) rescue nil
      errors.add(:base, "There's already something happening at #{MySettings.site_url}#{path}.  Try giving the page a different name.") if match && !match[:slugs]
    end

    def set_slug_and_path
      self.slug = title.parameterize

      parent, pages = self.parent, [slug]
      while parent
        pages << parent.slug
        parent = parent.parent
      end
      self.path = '/' + pages.reverse.join('/')
    end

    def parent_is_not_in_tree
      if id && [id, descendants.map(&:id)].flatten.include?(parent_id)
        msg = 'cannot be itself or one of its subpages.'
        errors.add(:parent_id, msg)
      end
    end
  end
end
