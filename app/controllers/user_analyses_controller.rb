class UserAnalysesController < ApplicationController
  before_action :set_user_analysis, only: [:show, :edit, :update, :destroy]

  # GET /user_analyses
  # GET /user_analyses.json
  def index
    @user_analyses = UserAnalysis.all
  end

  # GET /user_analyses/1
  # GET /user_analyses/1.json
  def show
  end

  # GET /user_analyses/new
  def new
    @user_analysis = UserAnalysis.new
  end

  # GET /user_analyses/1/edit
  def edit
  end

  # POST /user_analyses
  # POST /user_analyses.json
  def create
    @user_analysis = UserAnalysis.new(user_analysis_params)

    respond_to do |format|
      if @user_analysis.save
        format.html { redirect_to @user_analysis, notice: 'User analysis was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_analysis }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_analyses/1
  # PATCH/PUT /user_analyses/1.json
  def update
    respond_to do |format|
      if @user_analysis.update(user_analysis_params)
        format.html { redirect_to @user_analysis, notice: 'User analysis was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_analyses/1
  # DELETE /user_analyses/1.json
  def destroy
    @user_analysis.destroy
    respond_to do |format|
      format.html { redirect_to user_analyses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_analysis
      @user_analysis = UserAnalysis.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_analysis_params
      params.require(:user_analysis).permit(:rate)
    end
end
