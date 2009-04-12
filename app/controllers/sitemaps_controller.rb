class SitemapsController < ActionController::Base
  before_filter :set_locale
  
  def set_locale
    subdomain = request.env['SERVER_NAME'].split(".").first
    # set locale based on user profile if logged_in
    # if the user is NOT logged in, if 'fr' or 'en' is preceding hostname, the locale will be forced to this value
    locale = subdomain if Language::CODES.include?(subdomain) 
    I18n.locale = locale || 
      request.compatible_language_from(Language::CODES) || 
      I18n.default_locale
    I18n.locale = I18n.locale.to_sym
  end
  
  def show
    @widgets = SitemapWidget.find(:all)
    @site = SitemapSetting.find(:first)
    @static_links = SitemapStaticLink.find(:all)
    respond_to do |format|
      format.html
      format.xml
      format.css
      format.xsl
    end
  end
  
end