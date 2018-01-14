class VacationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_owner, only: [:show, :edit, :update, :destroy]

  # GET /vacations
  # GET /vacations.json
  def index
    if user_signed_in?
      @vacations = current_user.vacations
    else
      redirect_to  new_user_session_path
    end
    current_user.calculate
  end

  # GET /vacations/1
  # GET /vacations/1.json
  def show
  end

  # GET /vacations/new
  def new
    @vacation = Vacation.new
    if current_user.balance == 0
      flash[:notice] = "Sorry, your vacation balance is 0" 
      redirect_to vacations_path
    end
  end

  # GET /vacations/1/edit
  def edit
  end

  # POST /vacations
  # POST /vacations.json
  def create
    @vacation = Vacation.new(vacation_params)
    @vacation.user_id = current_user.id
   
    if @vacation.end_date < @vacation.start_date
      flash[:alert] = "Dates are not selected correctly"
      redirect_to new_vacation_path
    else   
      @vacation.days_count = calculate_business_days
      if  @vacation.days_count > current_user.balance || current_user.balance < 1
        flash[:alert] = "Your balance is less than the specified number of days"
        redirect_to new_vacation_path
      else
        current_user.calculate
        respond_to do |format|
          if @vacation.save
            format.html { redirect_to vacations_path, notice: 'Vacation was successfully created.' }
          else
            format.html { render :new }
          end
        end
      end
    end
  end

  # PATCH/PUT /vacations/1
  # PATCH/PUT /vacations/1.json
  def update
    if vacation_params[:end_date] < vacation_params[:start_date]
      flash[:alert] = "Dates are not selected correctly"
      redirect_to edit_vacation_path
    else   
      @vacation.days_count = calculate_business_days
         
      if  @vacation.days_count > current_user.balance || current_user.balance < 1
        flash[:alert] = "Your balance is less than the specified number of days"
        redirect_to edit_vacation_path
      else
        current_user.calculate
        respond_to do |format|
          if @vacation.update(vacation_params)
            format.html { redirect_to vacations_path, notice: 'Vacation was successfully updated.' }
          else
            format.html { render :edit }
          end
       end
      end
    end
  end

  # DELETE /vacations/1
  # DELETE /vacations/1.json
  def destroy
    current_user.calculate
    @vacation.destroy
    respond_to do |format|
      format.html { redirect_to vacations_url, notice: 'Vacation was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owner
      @vacation = Vacation.find(params[:id])
      unless @vacation.user == current_user
        flash[:notice] = "You can edit only your own vacation!"
        redirect_to :back
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vacation_params
      params.require(:vacation).permit(:start_date, :end_date, :description, :user_id, :days_count)
    end

    def calculate_business_days
      @weekday_numbers = [1,2,3,4,5]
      @business_days = (vacation_params[:start_date].to_datetime..vacation_params[:end_date].to_datetime).select{ |d| @weekday_numbers.include?( d.wday ) }
      return @business_days.length
    end
end