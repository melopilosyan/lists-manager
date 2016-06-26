class HomeController < ApplicationController

  def index
  end

  def close
    puts 'HomeController#close', params.to_json
  end
end

