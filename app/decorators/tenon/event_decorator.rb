module Tenon
  class EventDecorator < ApplicationDecorator
    def display_date
      if @object.starts_at.to_date == @object.ends_at.to_date
        "#{@object.starts_at.strftime('%B %d, %Y')} from #{@object.starts_at.strftime('%I:%M%p')} until #{@object.ends_at.strftime('%I:%M%p')}"
      else
        "#{@object.starts_at.strftime("%B %d, %Y at %I:%M%p")} until #{@object.ends_at.strftime("%B %d, %Y at %I:%M%p")}"
      end
    end
  end
end
