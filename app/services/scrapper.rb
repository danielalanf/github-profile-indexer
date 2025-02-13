require "httparty"

class Scrapper
  def initialize(github_url:)
      @github_url = github_url
      @attributes = {}
  end

  def find_attributes
    html = HTTParty.get(github_url)
    page = Nokogiri::HTML(html.body)
    attributes[:github_user] =
        page.xpath("//span[@itemprop=\"additionalName\"]").text.strip
    attributes[:followers] =
        page.xpath("//a[contains(@href, \"followers\")]/span").text.strip.to_i
    attributes[:following] =
        page.xpath("//a[contains(@href, \"following\")]/span").text.strip.to_i
    attributes[:stars] =
        page.xpath("(//a[@data-tab-item = \"stars\"]/span)[1]").text.strip.to_i
    attributes[:last_year_contributions] =
        page.xpath("//*[@class=\"js-yearly-contributions\"]/div/h2").text.strip.split("\n").first.to_i
    attributes[:image_url] =
        page.xpath("//*[@alt=\"Avatar\"]/@src").text
    attributes[:organization] =
        page.xpath("//ul[@class=\"vcard-details\"]/li[@itemprop=\"worksFor\"]/span/div").text
    attributes[:location] =
        page.xpath("//ul[@class=\"vcard-details\"]/li[@itemprop=\"homeLocation\"]/span").text
    attributes
  end

  private

  attr_accessor :github_url, :attributes
end
