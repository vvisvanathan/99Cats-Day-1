class CatsController < ApplicationController


  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by_id(params[:id])
    if @cat
      render :show
    else
      render :index
    end
  end

  def new
    @cat = Cat.new(name: "", birth_date: Date.today, color: "choose_color", sex: "U", description: "")
    render :new
  end

  def create
    @cat = Cat.create!(cat_params)
    if @cat
      render :show
    else
      render :index
    end
  end

  def edit
    @cat = Cat.find_by_id(params[:id])
    if @cat
      render :edit
    else
      render :index
    end
  end

  def update
    @cat = Cat.update(params[:id], cat_params)
    redirect_to cats_url
  end

  private

  def cat_params
    params[:cat].permit(:name, :color, :birth_date, :sex, :description)
  end
end
