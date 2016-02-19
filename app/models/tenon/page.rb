module Tenon
  class Page < ActiveRecord::Base
    # Scopes, Attrs, Etc.
    acts_as_nested_set
    has_history except: [:lft, :rgt, :parent_id, :depth],
                includes: [:content_tenon_content_rows]
    tenon_content :content, i18n: true
    default_scope { order('tenon_pages.lft, tenon_pages.list_order') }
    scope :published, -> { where('publish_at <= ?', Time.now) }
    scope :for_menu, -> { published.where(show_in_menu: true) }
    scope :top, -> { where(parent_id: nil) }
    scope :find_for_menu, -> { top.for_menu } # Backwards compatibility


    # Relationships
    belongs_to :parent, class_name: 'Page', foreign_key: 'parent_id'
    belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
    belongs_to :updater, class_name: 'User', foreign_key: 'updater_id'
    has_many :subpages, -> { order 'list_order' }, class_name: 'Page', foreign_key: 'parent_id', dependent: :destroy

    # Validations
    before_validation :set_slug_and_path
    after_move :set_slug_and_path
    validates_presence_of :title
    validates_presence_of :slug, message: I18n.t('tenon.pages.must_exist_in_order_to_have')
    validates_uniqueness_of :slug, scope: :parent_id
    validate :path_is_not_route
    validate :parent_is_not_in_tree

    # Return siblings if subpages aren't available
    def subpages_for_menu
      if subpages.blank?
        siblings_for_menu
      else
        subpages.for_menu
      end
    end

    def siblings_for_menu
      if parent
        parent.subpages_for_menu
      else
        []
      end
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

    def published?
      publish_at.present? ? publish_at <= Time.now : false
    end

    # Update each subpage.path up the tree:
    after_save :update_subpage_slugs
    def update_subpage_slugs
      subpages.each(&:save)
    end

    protected

    def path_is_not_route
      match = Rails.application.routes.recognize_path(path, method: :get) rescue nil
      errors.add(:base, I18n.t('tenon.pages.theres_already_something_happening', path: "#{MySettings.site_url}#{path}")) if match && !match[:slugs]
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
        msg = I18n.t('tenon.pages.cannot_be_itself_or_one_of_its_subpages')
        errors.add(:parent_id, msg)
      end
    end
  end
end
