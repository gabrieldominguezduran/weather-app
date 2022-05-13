# frozen_string_literal: true
require 'net/http'
class HomeController < ApplicationController
  def index
  api_key = '20320685c974788b7a9114665096319d'
  url = URI.parse("https://api.openweathermap.org/data/2.5/weather?lat=51.841986&lon=16.593755&units=metric&appid=#{api_key}")
  uri = URI(url)
  res = Net::HTTP.get_response(uri)
  @data = JSON.parse(res.body)
  end  
end
