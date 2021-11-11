class CriticsController < ApplicationController
  before_action :set_criticable

  # GET /games/:game_id/critics
  # GET /companies/:company_id/critics
  def index
    @critics = policy_scope(Critic).where(criticable: @criticable)
    authorize Critic

    @critic = Critic.new
  end

  # POST /games/:game_id/critics
  # POST /companies/:company_id/critics
  def create
    @critic = authorize Critic.new(critic_params)
    @critic.criticable = @criticable
    @critic.user = current_user

    if @critic.save
      redirect_to criticable_critics_path
    else
      @critics = @criticable.critics
      render :index
    end
  end

  # DELETE /games/:game_id/critics/:id
  # DELETE /companies/:company_id/critics/:id
  def destroy
    @critic = authorize @criticable.critics.find(params[:id])
    @critic.destroy
    redirect_to criticable_critics_path
  end

  # PATCH /games/:game_id/critics/:id?approved="1"
  # PATCH /companies/:company_id/critics/:id?approved="1"
  def update
    return unless params[:approved]

    @critic = authorize @criticable.critics.find(params[:id])

    if @critic.update(approved: params[:approved])
      redirect_to criticable_critics_path
    else
      flash[:alert] = 'Something went wrong'
    end
  end

  private

  def critic_params
    params.require(:critic).permit(:title, :body)
  end

  def set_criticable
    if params[:game_id]
      @criticable = Game.find(params[:game_id])
    elsif params[:company_id]
      @criticable = Company.find(params[:company_id])
    end
  end

  def criticable_critics_path
    case @criticable.class.to_s
    when 'Game'
      game_critics_path(@criticable)
    when 'Company'
      company_critics_path(@criticable)
    end
  end
end
