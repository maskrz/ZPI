class AnalisiesController < ApplicationController
  before_action :set_analisy, only: [:show, :edit, :update, :destroy]

  # GET /analisies
  # GET /analisies.json
  def index
    @analisies = Analisy.all
  end

  # GET /analisies/1
  # GET /analisies/1.json
  def show
  end

  # GET /analisies/new
  def new
    @analisy = Analisy.new
  end

  # GET /analisies/1/edit
  def edit
  end

  # POST /analisies
  # POST /analisies.json
  def create
    @analisy = Analisy.new(analisy_params)

    respond_to do |format|
      if @analisy.save
        format.html { redirect_to @analisy, notice: 'Analisy was successfully created.' }
        format.json { render action: 'show', status: :created, location: @analisy }
      else
        format.html { render action: 'new' }
        format.json { render json: @analisy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /analisies/1
  # PATCH/PUT /analisies/1.json
  def update
    respond_to do |format|
      if @analisy.update(analisy_params)
        format.html { redirect_to @analisy, notice: 'Analisy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @analisy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /analisies/1
  # DELETE /analisies/1.json
  def destroy
    @analisy.destroy
    respond_to do |format|
      format.html { redirect_to analisies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_analisy
      @analisy = Analisy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def analisy_params
      params.require(:analisy).permit(:lowest_rate, :medium_rate, :highest_rate, :algoritms_rate, :period, :date)
    end
end
