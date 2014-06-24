# If the app catches a 404, check Redirect records for a match.

# Use -> Add the following to application_controller.rb:
# rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
# private
# def record_not_found
#   redirect_to Tenon::Redirector.new(request.env['PATH_INFO']).redirect
# end

module Tenon
  class Redirector
    def initialize(path, redirects = Tenon::Redirect.active)
      @path = path
      @redirects = redirects
    end

    def redirect
      # If 404 -> Compare the path to all Redirect records:
      @destination = get_destination
      # raise @destination.inspect
      if @destination.present?
        # If there is a match return destination:
        return @destination
      else
        # Else -> trigger the 404 again:
        raise ActiveRecord::RecordNotFound
      end
    end

    private

    def get_destination
      @redirects.each do |redirect|
        if @path.match(/#{redirect.in}/).present?
          return redirect_match(redirect)
        end
      end
      nil
    end

    def redirect_match(redirect)
      @destination = redirect.out
      captures = @path.match(/#{redirect.in}/).captures
      if captures.present?
        captures.each_with_index do |capture, i|
          @destination = @destination.gsub(/\{#{i}\}/, capture)
        end
      end
      @destination
    end
  end
end
