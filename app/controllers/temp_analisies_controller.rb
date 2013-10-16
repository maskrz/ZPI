class TempAnalisiesController < ApplicationController
  before_action :set_temp_analisy, only: [:show, :edit, :update, :destroy]

  # GET /temp_analisies
  # GET /temp_analisies.json
  def index
    @temp_analisies = TempAnalisy.all
  end

  # GET /temp_analisies/1
  # GET /temp_analisies/1.json
  def show
  end

  # GET /temp_analisies/new
  def new
    @temp_analisy = TempAnalisy.new
  end

  # GET /temp_analisies/1/edit
  def edit
  end

  # POST /temp_analisies
  # POST /temp_analisies.json
  def create
    @temp_analisy = TempAnalisy.new(temp_analisy_params)

    respond_to do |format|
      if @temp_analisy.save
        format.html { redirect_to @temp_analisy, notice: 'Temp analisy was successfully created.' }
        format.json { render action: 'show', status: :created, location: @temp_analisy }
      else
        format.html { render action: 'new' }
        format.json { render json: @temp_analisy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temp_analisies/1
  # PATCH/PUT /temp_analisies/1.json
  def update
    respond_to do |format|
      if @temp_analisy.update(temp_analisy_params)
        format.html { redirect_to @temp_analisy, notice: 'Temp analisy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @temp_analisy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temp_analisies/1
  # DELETE /temp_analisies/1.json
  def destroy
    @temp_analisy.destroy
    respond_to do |format|
      format.html { redirect_to temp_analisies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp_analisy
      @temp_analisy = TempAnalisy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def temp_analisy_params
      params.require(:temp_analisy).permit(:lowest_rate, :medium_rate, :highest_rate, :algoritms_rate, :period, :date)
    end
end
