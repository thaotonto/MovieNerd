module ApplicationHelper
  def full_title page_title = ""
    base_title = t "layouts.application.page_title"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def ticket_price
    if I18n.locale == :vi
      Settings.price_vnd
    elsif I18n.locale == :en
      Settings.price_usd
    end
  end
end
