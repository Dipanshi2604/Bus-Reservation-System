class HomeController < ApplicationController
  def index
    @buses = Bus.all
  end
end
