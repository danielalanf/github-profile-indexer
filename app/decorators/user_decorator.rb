class UserDecorator < Draper::Decorator
  delegate_all

  def profile_image
    h.image_tag(object.image_url.presence || "usuario-placeholder.png",
                class: "rounded-circle",
                width: 150,
                height: 150)
  end

  def github_link
    h.link_to object.original_github_url, target: "_blank", class: "text-blue" do
      h.concat h.content_tag(:i, "", class: "fa-brands fa-github")
      h.concat " "
      h.concat object.github_url
    end
  end

  def followers
    formatted_amount(object.followers)
  end

  def following
    formatted_amount(object.following)
  end

  def stars
    formatted_amount(object.stars)
  end

  def last_year_contributions
    formatted_amount(object.last_year_contributions)
  end

  def organization
  end

  def location_with_icon
    if object.location.present?
      h.content_tag(:span, class: "location") do
        h.concat h.content_tag(:i, "", class: "fas fa-map-marker-alt")
        h.concat " "
        h.concat object.location
      end
    end
  end

  def organization_with_icon
    if object.organization.present?
      h.content_tag(:span, class: "organization") do
        h.concat h.content_tag(:i, "", class: "fas fa-building")
        h.concat " "
        h.concat object.organization
      end
    end
  end

  private

  def formatted_amount(value)
    case value
    when 1_000_000_000..Float::INFINITY
      "#{(value / 1_000_000_000.0).round(1)}B"
    when 1_000_000..999_999_999
      "#{(value / 1_000_000.0).round(1)}M"
    when 1_000..999_999
      "#{(value / 1_000.0).round(1)}K"
    else
      value
    end
  end
end
