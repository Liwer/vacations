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

    if vacation_params[:start_date] && vacation_params[:end_date] == ""
      flash[:notice] = "Please select dates"
      redirect_to new_vacation_path
    else
      @vacation.days_count = calculate_business_days
      if  @vacation.days_count > current_user.balance || current_user.balance < 1
        flash[:alert] = "Your balance is less than the specified number of days"
        redirect_to new_vacation_path
      else
        current_user.calculate
          unless validate_vacation_date(vacation_params, "create")
            flash[:notice] = "For these dates, already scheduled vacation, please choose other dates"
            redirect_to new_vacation_path
          else
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
  end

  # PATCH/PUT /vacations/1
  # PATCH/PUT /vacations/1.json
  def update
    @vacation.days_count = calculate_business_days
    if  @vacation.days_count > current_user.balance || current_user.balance < 1
      flash[:alert] = "Your balance is less than the specified number of days"
      redirect_to edit_vacation_path
    else
      current_user.calculate
       
      unless validate_vacation_date(vacation_params, "update")
          flash[:notice] = "For these dates, already scheduled vacation, please choose other dates"
          redirect_to edit_vacation_path
      else
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

    def validate_vacation_date(vacation_params, action)
      @vacations = current_user.vacations.where("cast(strftime('%Y', start_date) as int) = ?", vacation_params[:start_date].to_datetime.year ).to_a
      @vacations = @vacations.reject!{ |v| v.id == params[:id].to_i} if action == "update"
      @vacations_range = []
      @vacations.each do |vacation|
        @vacations_range.concat(vacation.transform_vacation_to_years_days)
      end
      
      @current_vacation_range = (vacation_params[:start_date].to_datetime.yday..vacation_params[:end_date].to_datetime.yday)
      if @current_vacation_range.any?{|year| @vacations_range.include?(year)}
        return false
      else
        return true
      end
    end
end