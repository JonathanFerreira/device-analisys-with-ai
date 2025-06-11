class SaleValidationsController < ApplicationController
  before_action :set_sale, only: [:edit, :update, :start_validation]

  def edit
    @sale_cycle.next_step! if @sale_cycle.first_step?
  end

  def update
    @sale_cycle.assign_attributes(sale_cycle_params)

    if @sale_cycle.save
      @sale_cycle.next_step!
      redirect_to edit_sale_validation_path(@sale_cycle)
    else
      render :edit
    end
  end

  def start_validation
    @sale_cycle.next_step!
    redirect_to edit_sale_validation_path(@sale_cycle)
  end

  private

  def set_sale
    record = SaleCycle.find(params[:id])

    @sale_cycle = record.specialized_instance
  end

  def sale_cycle_params
    params.require(:sale_cycle).permit(:imei, :front_photo, :back_photo)
  end
end
