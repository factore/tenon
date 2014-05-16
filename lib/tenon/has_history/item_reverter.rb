module Tenon
  module HasHistory
    class ItemReverter
      def self.revert(*args)
        new(*args).revert
      end

      def initialize(item, item_version)
        @item = item
        @item_version = item_version
      end

      def revert
        remove_saved_associations
        @item.assign_attributes(params.permit!)
      end

      private

      def params
        ActionController::Parameters.new(Marshal.load(@item_version.attrs))
      end

      # This inserts the existing associations into the form
      # but it marks them for destruction.  This way they don't "show"
      # to the user and if the user saves the form the old associations
      # will be deleted and the new ones saved, preventing any duplicates.
      def remove_saved_associations
        @item.has_history_includes.each do |assoc_name|
          assoc = @item.send(assoc_name)
          if assoc.respond_to?(:each)
            assoc.each(&:mark_for_destruction)
          else
            assoc.mark_for_destruction
          end
        end
      end
    end
  end
end
