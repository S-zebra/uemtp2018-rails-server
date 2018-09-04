module ApplicationHelper
  def page_title
    if @title
      "De.tales - " + @title
    else
      "De.tales"
    end
  end
end
