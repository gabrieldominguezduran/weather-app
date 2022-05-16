# frozen_string_literal: true
require 'net/http'
class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:states, :cities, :weather]
  def show
  end

  def countries
    countries = CS.get
    render json: countries
  end

  def states
    states = CS.states(params[:selCountry])
    render json: states
  end

  def cities
    cities = CS.cities(params[:selState], params[:selCountry])
    render json: cities
  end

  def weather
  api_key = ENV["API_KEY"]  
  url = URI.parse("https://api.openweathermap.org/data/2.5/weather?q=#{params[:selCity]}&units=metric&appid=#{api_key}")
  uri = URI(url)
  res = Net::HTTP.get_response(uri)
  render json: res.body
  end  
end
