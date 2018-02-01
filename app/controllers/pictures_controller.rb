class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:index, :new, :edit, :show]

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  # GET /pictures/new
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    @picture.image.retrieve_from_cache! params[:cache][:image]
#    @semail = User.find(picture.user_id).email

    respond_to do |format|
      if @picture.save
      ContactMailer.contact_mail(current_user.email).deliver
#      redirect_to pictures_path, notice: "画像を投稿しました！"
        format.html { redirect_to @picture, notice: '画像をアップロードしました！' }
        format.json { render :show, status: :created, location: @picture }
      else
#      render 'new'
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
#      redirect_to pictures_path, notice: "ブログを編集しました！"
        format.html { redirect_to @picture, notice: '画像を更新しました！' }
        format.json { render :show, status: :ok, location: @picture }
      else
#      render 'edit'
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
#    redirect_to pictures_path, notice:"ブログを削除しました！"
      format.html { redirect_to pictures_url, notice: '画像を削除しました！' }
      format.json { head :no_content }
    end
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.image.cache!
    render :new if @picture.invalid?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
#      params.require(:picture).permit(:image, :content, :user_id)
      params.require(:picture).permit(:image, :content)
    end
    
    def require_login
      unless logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_user_url # halts request cycle
      end
    end

end
