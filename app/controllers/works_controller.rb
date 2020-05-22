class WorksController < ApplicationController
  def index
    @works = Work.all
  end
  
  def show
    word_id = params[:id]
    @work = Work.find_by(id: passenger_id)
    
    if @passenger.nil?
      head :not_found
      return
    end
  end
  def new
    @work = Work.new
  end
end
