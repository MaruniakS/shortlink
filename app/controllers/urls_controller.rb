class UrlsController < ApplicationController
  def show
    @url = Url.where('short = :short or custom = :short', short: params[:short]).first
    redirect_to @url.long and return if @url
    redirect_to root_path, flash: { error: 'Url was not found, try another!' }
  end

  def create
    @url = Url.find_or_create_by(url_params)
    render template: 'urls/errors.js.erb' unless @url.errors.empty?
  end

  def custom
    @url = Url.new
  end

  private
  def url_params
    params.require(:url).permit(:long, :custom)
  end
end
