module Tenon
  module PieceHelper
    def backend_piece_image_tag(piece, options = {})
      piece_image_tag(piece, options, Tenon.config.back_end[:breakpoints])
    end

    def frontend_piece_image_tag(piece, options = {})
      piece_image_tag(piece, options, Tenon.config.front_end[:breakpoints])
    end

    def piece_image_tag(piece, options = {}, breakpoints)
      srcset = generate_srcset(piece)
      sizes = generate_sizes(piece, breakpoints)
      image_tag(piece.image.url(:twelve), options.merge(srcset: srcset, sizes: sizes))
    end

    private

    def generate_sizes(piece, breakpoints)
      piece_size = piece.size == '' ? 'twelve' : piece.size
      breakpoints.map do |name, sizes|
        "(max-width: #{sizes[:browser]}) #{(piece.sizes[piece_size.to_sym]/12*100*sizes[:content]/sizes[:browser]).to_i}vw"
      end.join(', ')
    end

    def generate_srcset(piece)
      piece.styles.map do |name, width|
        if piece.image.attachment.exists?(computed_style(piece, name).to_sym)
          "#{piece.image.attachment.url(computed_style(piece, name).to_sym)} #{width}w"
        end
      end.join(', ')
    end

    def computed_style(piece, style)
      computed_style = "#{piece.image.style_prefix}_#{style}"
    end
  end
end
