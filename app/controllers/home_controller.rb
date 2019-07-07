class HomeController < ApplicationController
  #before_action :authenticate_user!
  def index
       @search = Ticket.ransack(params[:q])
       @tickets = @search.result.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end
  
end
