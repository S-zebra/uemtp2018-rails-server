module ApplicationHelper
  APP_NAME = "つくもっく"

  def page_title
    if @title
      "#{APP_NAME} - #{@title}"
    else
      APP_NAME
    end
  end
end
