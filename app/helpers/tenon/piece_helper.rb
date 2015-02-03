module Tenon
  module PieceHelper
    def piece_image_tag(piece, options = {})
      responsive_image_tag(piece, options, Tenon.config.breakpoints.front_end)
    end

    def backend_piece_image_tag(piece, options = {})
      responsive_image_tag(piece, options, Tenon.config.breakpoints.back_end)
    end

    private
      # Returns the actual image_tag
      def responsive_image_tag(piece, options = {}, breakpoints)
        srcset = generate_srcset(piece)
        sizes = generate_sizes(piece, breakpoints)
        image_tag(piece.image.url(default_style(piece, breakpoints)), options.merge(srcset: srcset, sizes: sizes))
      end

      # Figure out the default style based on the largest size at the largest
      # breakpoint for browsers that don't support srcset. This is at least
      # better than always serving the largest style (:x2000).
      def default_style(piece, breakpoints)
        sizes = breakpoints[:full]

        # calculate the image size at :full breakpoint based on the piece width
        image_size = (piece.sizes[piece_size(piece).to_sym] / 12 * content_size(sizes, piece)).to_i

        # round up to nearest 200
        image_size = image_size.round(-2)
        image_size += 100 if (image_size / 100).odd?

        default_style = computed_style(piece, "x#{image_size}").to_sym

        piece.image.attachment.exists?(default_style) ? default_style : :original
      end

      # Iterate through the defined breakpoints and lookup the tenon_content
      # sizes for the piece's row's item type. Use sizes[:default] width if
      # item_type-specific tenon_content width not defined.
      def generate_sizes(piece, breakpoints)
        breakpoints.map do |name, sizes|
          "(min-width: #{sizes[:browser]}px) #{(piece.sizes[piece_size(piece).to_sym] / 12 * 100 * content_size(sizes, piece) / sizes[:browser]).to_i}vw"
        end.join(', ')
      end

      # Build the srcset values from the list of piece styles (2000px-200px)
      def generate_srcset(piece)
        piece.styles.map do |name, width|
          if piece.image.attachment.exists?(computed_style(piece, name).to_sym)
            "#{piece.image.attachment.url(computed_style(piece, name).to_sym)} #{width}w"
          else
            "#{piece.image.attachment.url(:original)} #{width}w"
          end
        end.join(', ')
      end

      # Handle 'twelve' pieces that have size set to '' in the db
      def piece_size(piece)
        piece_size = piece.size == '' ? 'twelve' : piece.size
      end

      def computed_style(piece, style)
        computed_style = "#{piece.image.style_prefix}_#{style}"
      end

      # Return the width of tenon_content for this piece, or the :default size
      def content_size(sizes, piece)
        sizes[piece.row.item_type.demodulize.downcase.to_sym] || sizes[:default]
      end
  end
end
