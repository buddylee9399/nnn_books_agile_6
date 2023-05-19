class PagesController < ApplicationController
  def home
    @files = Dir.glob('*')
  end
end
