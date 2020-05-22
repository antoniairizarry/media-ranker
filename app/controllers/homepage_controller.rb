class HomepageController < ApplicationController
  #TODO
  def index
    @works = Work.all
  end
end