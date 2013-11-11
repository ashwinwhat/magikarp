class ProvidersController < ApplicationController

  def index

  end

  def create
    @provider = Provider.new(params)
    render test_options
  end
end
