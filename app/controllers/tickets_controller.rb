class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /tickets
  # GET /tickets.json
  def index
    @search = Ticket.ransack(params[:q])
    @tickets = @search.result.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = current_user.tickets.build #Ticket.new
    @ticket.price = 10
    @ticket.user = current_user
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create

    @ticket = current_user.tickets.build(ticket_params)
    @ticket.price = 10
    @ticket.user_id = current_user.id

    if @ticket.motorcycle_parking == true
      @ticket.sub_total = (@ticket.persons * @ticket.price) + 5
    else
      @ticket.sub_total = @ticket.persons * @ticket.price
    end

    @ticket.memo_no = Array.new(6) {rand(9)}.join.to_i

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
   
   if current_user.admin 
    @ticket.persons = @ticket.persons
      if @ticket.motorcycle_parking == false
        @ticket.sub_total = @ticket.sub_total + 5
      else
        @ticket.sub_total
      end

      if @ticket.motorcycle_parking == true
        @ticket.sub_total = @ticket.sub_total - 5
      else
        @ticket.sub_total
      end
    end

    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end

    
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
   
    if current_user.admin  
        @ticket.destroy
        respond_to do |format|
          format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:date, :persons, :price, :user_id, :sub_total, :motorcycle_parking, :memo_no)
    end
end
