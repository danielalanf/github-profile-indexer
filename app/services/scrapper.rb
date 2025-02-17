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
    @page = Nokogiri::HTML(html.body)
    extract_attributes(page)
  end

  private

  attr_accessor :github_url, :user, :attributes, :page

  def extract_attributes(page)
    attributes[:nickname] =
      page.at_xpath("//span[@itemprop='additionalName']")&.text&.strip
    attributes[:image_url] =
      page.at_xpath("//img[contains(@class, 'avatar-user')]/@src")&.value&.sub(/\?s=\d+&?/, "?")
    attributes[:followers] =
      find_integer_attributes("//a[contains(@href, 'followers')]/span")
    attributes[:following] =
      find_integer_attributes("//a[contains(@href, 'following')]/span")
    attributes[:stars] =
      find_integer_attributes("(//a[@data-tab-item = 'stars']/span)[1]")
    attributes[:last_year_contributions] =
      page.at_xpath("//*[@class='js-yearly-contributions']//h2")&.text&.strip&.scan(/\d+/)&.first.to_i
    attributes[:organization] =
      page.at_xpath("//ul[contains(@class, 'vcard-details')]/li[@itemprop='worksFor']//span")&.text&.strip
    attributes[:location] =
      page.at_xpath("//ul[contains(@class, 'vcard-details')]/li[@itemprop='homeLocation']/span")&.text&.strip

    attributes
  end

  def find_integer_attributes(text)
    number = page.at_xpath(text)&.text&.strip
    parse_attributes(number)
  end

  def parse_attributes(value)
    return 0 if value.nil?

    if value.match?(/k/i)
      (value.to_f * 1000).to_i
    elsif value.match?(/m/i)
      (value.to_f * 1_000_000).to_i
    else
      value.to_i
    end
  end
end
