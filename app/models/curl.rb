class Curl
  include ActiveModel::Validations
  include ActiveModel::Conversions
  extend ActiveModel::Naming

  attr_accessor :url, :content_type, :accept, :auth, :data

  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value)
    end
  end

  def run
    uri = URI(url)

    if data.nil?
      request = Net::HTTP::Get.new(uri.path)
    else
      request = Net::HTTP::Post.new(uri.path)
      request.body = data
    end

    request['Content-Type'] = content_type || 'application/xml'
    request['Accept'] = accept || 'application/xml'
    request['Authorization'] = "Basic #{auth}" unless auth.nil?

    Net::HTTP.new(uri.host, uri.port) do |http|
      http.request(request)
    end
  end

  def persisted?
    false
  end
end