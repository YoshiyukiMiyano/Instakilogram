class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
          redirect_to user_path(@user.id)
        else
          render 'new'
        end
    end
    
    def show
        @user = User.find(params[:id])
        @favorites_pictures = @user.favorites
#        @favorites_blogs = @user.favorites
    end
    
    def edit
    end

  def update
    @user = User.update(user_params)
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'user was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def user_params
        params.require(:user).permit(:name, :email, :password, :profile_image,
                                     :password_confirmation)
    end
end
