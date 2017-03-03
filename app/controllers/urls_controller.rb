class UrlsController < ApplicationController
  def show
    @url = Url.find_by(id: Url.get_id(params[:short]))
    redirect_to @url.long
  end

  def create
    @url = Url.find_or_create_by(url_params)
    render template: 'urls/errors.js.erb' unless @url.errors.empty?
  end

  private
  def url_params
    params.require(:url).permit(:long, :custom)
  end
end
