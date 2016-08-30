class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver
      login(@user)
      if @user.patient
        @patient = Patient.create(user_id: @user.id)
        flash[:success] = "Successfully created a patient account"
        redirect_to patient_path(@patient.id)
      else
        flash[:success] = "Successfully created a caregiver account"
        @caregiver = Caregiver.create(user_id: @user.id)
        redirect_to caregiver_path(@caregiver.id)
      end
    else
        flash[:error] = @user.errors.full_messages.join(", ")
        redirect_to new_user_path
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Successfully saved changes to User information."
      redirect_to '/'
    else
      flash[:error] = "Could not save changes to User information. Please try again."
      redirect_to :back
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :patient)
  end

end
