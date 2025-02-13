class ResultDecorator < Draper::Decorator
  def profile_image
    h.image_tag(object.profile_image.presence || "usuario-placeholder.png",
                class: "rounded-circle",
                width: 80,
                height: 80)
  end
end
