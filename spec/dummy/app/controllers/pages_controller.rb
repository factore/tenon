class PagesController < ApplicationController
  def show
    # this controller/view is only used to determine if the tenon_content
    # renders HTML properly. there are no styles.
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html { render layout: false }
    end
  end
end
