class UserFilter
  include ActiveModel::Model

  attr_accessor :params

  def initialize(attributes = {})
    return if attributes.nil?

    attributes.each do |name, value|
      send("#{name}=", value) if respond_to?("#{name}=")
    end
  end

  def persisted?
    false
  end

  def to_param
    {
      params: params
    }
  end
end
