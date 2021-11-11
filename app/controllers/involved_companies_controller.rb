class InvolvedCompaniesController < ApplicationController
  before_action :set_game
  # POST /games/:game_id/involved_companies   body { company_id: 19 }
  def create
    @ic = @game.involved_companies.find_or_initialize_by(company_id: ic_params[:company_id])
    create_if

    if @ic.save
      redirect_to @game
    else
      render 'games/show'
    end
  end

  # PATCH /games/:game_id/involved_companies/:id?developer="false"
  def update
    @ic = @game.involved_companies.find(params[:id])
    update_if

    @ic.destroy unless @ic.save

    redirect_to @game
  end

  # DELETE /games/:game_id/involved_companies/:id
  # def destroy
  #   @game = Game.find(params[:game_id])
  #   @ic = InvolvedCompany.find(params[:id])
  #   @ic.destroy
  #   redirect_to @game
  # end

  private

  def create_if
    authorize @ic
    @ic.developer = ic_params[:developer] if ic_params[:developer]
    @ic.publisher = ic_params[:publisher] if ic_params[:publisher]
  end

  def update_if
    authorize @ic
    @ic.developer = params[:developer] if params[:developer]
    @ic.publisher = params[:publisher] if params[:publisher]
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  def ic_params
    params.require(:involved_company).permit(:developer, :publisher, :company_id)
  end
end
