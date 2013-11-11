class Provider
  include ActiveModel::Validations
  include ActiveModel::Conversions
  extend ActiveModel::Naming

  attr_accessor :name

  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value)
    end
  end

  def persisted?
    false
  end
end