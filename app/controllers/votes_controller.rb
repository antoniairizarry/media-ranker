class VotesController < ApplicationController

  def index
    @votes = Vote.all
  end

  def new
    @vote = Vote.new
  end

  def create
    if !session[:user_id]
      flash[:failure] = "Please Log In to Vote"
      redirect_back(fallback_location: root_path)
      return 
    end

    if Vote.where(user_id: session[:user_id], work_id: params[:work_id]).count > 0
      flash[:failure] = "You already voted for this work"
      redirect_back(fallback_location: root_path)
      return
    end

    vote = Vote.create(user_id: session[:user_id], work_id: params[:work_id])
    flash[:success] = "Vote added successfully"
    redirect_back(fallback_location: root_path)
    return
  end

  end