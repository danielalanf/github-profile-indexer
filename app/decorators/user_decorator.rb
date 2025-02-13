class UserDecorator < Draper::Decorator
  delegate_all

  def profile_image
    h.image_tag(object.github_url, alt: object.name, class: "img-thumbnail") if object.github_url.present?
  end
end
