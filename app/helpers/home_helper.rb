module HomeHelper
  def error_messages url
    url.errors.full_messages || []
  end
end
