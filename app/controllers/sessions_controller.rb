class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.confirm(user_params)
    if @user
      session[:user_id] = @user.id
      @current_user = @user
      if @user.patient
        @patient = Patient.find_by_user_id(@user.id)
        redirect_to patient_path(@patient)
      else
        @caregiver = Caregiver.find_by_user_id(@user.id)
        redirect_to caregiver_path(@caregiver)
      end
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end