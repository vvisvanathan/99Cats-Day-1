class CatRentalRequestsController < ApplicationController
  def new
    @cats = Cat.all
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.create!(cat_rental_request_params)
    if @cat_rental_request
      redirect_to cat_url(Cat.find_by_id(cat_rental_request_params[:cat_id]))
    else
      render :new
    end
  end

  def approve
    @cat_rental_request = CatRentalRequest.find_by_id(params[:id])
    if @cat_rental_request
      @cat_rental_request.approve!
      redirect_to cat_url(@cat_rental_request.cat)
    else
      redirect_to cat_url(@cat_rental_request.cat)
    end
  end

  def deny
    @cat_rental_request = CatRentalRequest.find_by_id(params[:id])
    if @cat_rental_request
      @cat_rental_request.deny!
      redirect_to cat_url(@cat_rental_request.cat)
    else
      redirect_to cat_url(@cat_rental_request.cat)
    end
  end

  private

  def cat_rental_request_params
    params[:cat_rental_request].permit(:cat_id, :start_date, :end_date, :status)
  end

end
