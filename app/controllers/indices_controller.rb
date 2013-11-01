class IndicesController < ApplicationController
  before_action :set_index, only: [:show, :edit, :update, :destroy]
  
  # GET /indices
  # GET /indices.json
  def index
    @indices = Index.all
  end

  # GET /indices/1
  # GET /indices/1.json
  def show
    @companies = @index.companies
  end

  # GET /indices/new
  def new
    @index = Index.new
  end

  # GET /indices/1/edit
  def edit
  end

  # POST /indices
  # POST /indices.json
  def create
    @index = Index.new(index_params)

    respond_to do |format|
      if @index.save
        format.html { redirect_to @index, notice: 'Index was successfully created.' }
        format.json { render action: 'show', status: :created, location: @index }
      else
        format.html { render action: 'new' }
        format.json { render json: @index.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /indices/1
  # PATCH/PUT /indices/1.json
  def update
    respond_to do |format|
      if @index.update(index_params)
        format.html { redirect_to @index, notice: 'Index was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @index.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /indices/1
  # DELETE /indices/1.json
  def destroy
    @index.destroy
    respond_to do |format|
      format.html { redirect_to indices_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_index
      @index = Index.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def index_params
      params.require(:index).permit(:name)
    end
    
end
