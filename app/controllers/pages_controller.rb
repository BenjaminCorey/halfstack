class PagesController < ApplicationController
  layout 'page'
  def show
    @page = Page.find_by_slug! params[:id]
  end
end
