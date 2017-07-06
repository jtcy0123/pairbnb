class SessionsController < Clearance::SessionsController

  def create
    @user = authenticate(params)

    sign_in(@user) do |status|
      if status.success?
        redirect_back_or url_after_create
      else
        @error = status.failure_message
        respond_to do |format|
          format.js
          format.html { render template: "sessions/new" }
        end
      end
    end
  end

end
