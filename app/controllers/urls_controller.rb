class UrlsController < ApplicationController
  def create
    @url = Url.find_or_create_by(url_params)
    if @url.errors.empty?
      render json: @url.as_json
    else
      render json: @url.errors.full_messages.as_json
    end
  end

  private
  def url_params
    params.require(:url).permit(:long, :custom)
  end
end
