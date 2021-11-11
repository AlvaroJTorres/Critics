class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show edit update destroy]

  # GET /companies
  def index
    @companies = Company.all
    authorize Company
    # render json: @companies
  end

  # GET /game/:id
  def show; end

  # GET /companies/new
  def new
    @company = authorize Company.new
  end

  # POST /companies
  def create
    @company = Company.new(company_params)
    authorize @company

    if @company.save
      redirect_to companies_path
    else
      render :new
    end
  end

  # GET /companies/:id/edit
  def edit; end

  # PATCH/PUT /companies/:id
  def update
    if @company.update(company_params)
      redirect_to companies_path
    else
      render :edit
    end
  end

  # DELETE /companies/:id
  def destroy
    @company.destroy
    redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(:name, :description, :country, :start_date, :cover)
  end

  def set_company
    @company = authorize Company.find(params[:id])
  end
end
