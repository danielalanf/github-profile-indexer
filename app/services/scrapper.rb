# frozen_string_literal: true

require "httparty"

class Scrapper
  def initialize(github_url:, user:)
    @github_url = github_url
    @user = user
    @attributes = {}
  end

  def find_attributes
    html = HTTParty.get(github_url)
    page = Nokogiri::HTML(html.body)
    extract_attributes(page)
  end

  private

  attr_accessor :github_url, :user, :attributes

  def extract_attributes(page)
    attributes[:nickname] =
      page.at_xpath("//span[@itemprop='additionalName']")&.text&.strip
    attributes[:image_url] =
      page.at_xpath("//img[contains(@class, 'avatar-user')]/@src")&.value&.sub(/\?s=\d+&?/, "?")
    attributes[:followers] =
      page.at_xpath("//a[contains(@href, 'followers')]/span")&.text&.strip&.gsub(/[^\d]/, "").to_i
    attributes[:following] =
      page.at_xpath("//a[contains(@href, 'following')]/span")&.text&.strip.to_i
    attributes[:stars] =
      page.at_xpath("(//a[@data-tab-item = 'stars']/span)[1]")&.text&.strip.to_i
    attributes[:last_year_contributions] =
      page.at_xpath("//*[@class='js-yearly-contributions']//h2")&.text&.strip&.scan(/\d+/)&.first.to_i
    attributes[:organization] =
      page.at_xpath("//ul[contains(@class, 'vcard-details')]/li[@itemprop='worksFor']//span")&.text&.strip
    attributes[:location] =
      page.at_xpath("//ul[contains(@class, 'vcard-details')]/li[@itemprop='homeLocation']/span")&.text&.strip

    attributes
  end
end
