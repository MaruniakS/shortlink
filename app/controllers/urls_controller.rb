class UrlsController < ApplicationController
  def create
    @url = Url.find_or_create_by(url_params)
    respond_to do |format|
      format.js
    end
  end

  private
  def url_params
    params.require(:url).permit(:long, :custom)
  end
end
