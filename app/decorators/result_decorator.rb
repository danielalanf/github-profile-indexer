class ResultDecorator < Draper::Decorator
  def profile_image
    h.image_tag(object.profile_image.presence || "usuario-placeholder.png",
                class: "rounded-circle",
                width: 80,
                height: 80)
  end

  def formatted_info
    h.content_tag(:ul, class: "list-unstyled mb-0") do
      h.concat h.content_tag(:li, object.name)
      h.concat h.content_tag(:li, object.nickname, class: "text-muted")
      h.concat h.content_tag(:li, github_link)
    end
  end

  private

  def github_link
    h.link_to object.github_url, target: "_blank", class: "text-blue fw-bold" do
      h.concat h.content_tag(:i, "", class: "fa-brands fa-github")
      h.concat " "
      h.concat object.github_url
    end
  end
end
