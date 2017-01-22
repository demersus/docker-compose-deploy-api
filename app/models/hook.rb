class Hook < ApplicationRecord
  belongs_to :service

  def perform
    require 'net/http'
    require 'uri'
    require 'json'

    uri = URI.parse(url)

    header = {'Content-Type': content_type}

    http = Net::HTTP.new(uri.host, uri.port)
    request = "Net::HTTP::#{method.capitalize}".constantize.new(uri.request_uri, header)

    if url.starts_with?("https")
      http.use_ssl = true
    end

    request.body = body

    puts "Sending #{action_type} hook for service: #{service_id}"
    puts "#{method}: #{url}, #{body}"
    response = http.request(request)
    puts "Got response: #{response.message}/#{response.code}"
  end
end
