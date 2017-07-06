class UsersController < Clearance::UsersController
  def new
    @user = User.new
    render template: "users/new"
  end

  def create
    @user = User.new(user_params)
    p @user.valid?
    p @user.errors.full_messages

    if @user.save
      # format.html { redirect_to @user, notice: 'User was successfully created.' }
      # format.js
      # format.json { render json: @user }
      sign_in @user
      redirect_to action: "new"
    else
      respond_to do |format|
        format.html { render action: "new" }
        format.js
        # format.json { render json: @user }
        # render template: "users/new"
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
