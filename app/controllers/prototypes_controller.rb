class PrototypesController < ApplicationController
  before_action :authenticate_user!,except: [:index, :show]
  before_action :set_prototype, only: [:edit, :show]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end


  def create
    @prototype = Prototype.create(prototype_params)
  
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

    def edit
      @prototype = Prototype.find(params[:id])
      unless @prototype.user_id == current_user.id
        redirect_to action: :index
      end
    end


  def update
    @prototype = Prototype.find(params[:id])
  
    if @prototype
      if @prototype.update(prototype_params)
        redirect_to prototype_path(@prototype)
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end
  

  private
  def prototype_params
    params.require(:prototype).permit(:image, :title, :catch_copy, :concept).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  
end

