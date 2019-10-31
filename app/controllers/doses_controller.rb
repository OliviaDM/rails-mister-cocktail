class DosesController < ApplicationController
  # def new
  #   @cocktail = Cocktail.find(params[:cocktail_id])
  #   @dose = Dose.new
  # end

  def create
    attribs = dose_params
    attribs[:cocktail_id] = params[:cocktail_id]
    @dose = Dose.new(attribs)

    if @dose.save
      redirect_to cocktail_path(params[:cocktail_id])
    else
      redirect_to new_cocktail_dose_path
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy

    redirect_to cocktail_path(params[:cocktail_id])
  end

  private

  def dose_params
    params.require(:dose).permit(:ingredient_id, :description)
  end
end
