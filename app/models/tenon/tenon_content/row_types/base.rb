module Tenon
  class TenonContent::RowTypes::Base
    class << self
      attr_accessor :partial, :form_partial

      def partial
        filename = name.demodulize.underscore
        File.join(partial_path, 'display', filename)
      end

      def form_partial
        filename = name.demodulize.underscore
        File.join(partial_path, 'form', filename)
      end

      def partial_path
        'tenon/tenon_content/row_types'
      end
    end
  end
end