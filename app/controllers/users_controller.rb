class UsersController < Clearance::UsersController
  def new
    @user = User.new
    render template: "users/new"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to action: "show", id: @user
    else
      respond_to do |format|
        format.html { render action: "new" }
        format.js
      end
    end
  end

  def show
    if signed_in?
      @user = User.find(params[:id])
    else
      redirect_to sign_in_path
    end
  end

  def edit
    if signed_in?
      @user = User.find(params[:id])
      render template: "users/edit"
    else
      redirect_to sign_in_path
    end
  end

  def update
    user = User.find(params[:id])
    user.photo = params[:user][:photo]
    user.save(:validate => false)
    redirect_to action: "show", id: user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :photo)
  end
end
