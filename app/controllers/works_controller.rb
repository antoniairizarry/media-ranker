class WorksController < ApplicationController
  def index
    @works = Work.all
  end
  
  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.nil?
      head :not_found
      return
    end
  end
  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work.id)
      return
    else
      render :new, status: :bad_request
      return
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      redirect_to work_path
      return
    else
      render :edit
      return
    end
  end

  def destroy
    work_id = params[:id]
    @work = Work.find_by_id(work_id)

    if @work.nil?
      head :not_found
      return
    end
    @work.destroy

    redirect_to works_path
    return
  end
end

end

def work_params
  return params.require(:work).permit(:category, :title, :artist, :published, :description)
end