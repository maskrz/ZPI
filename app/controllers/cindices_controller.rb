class CindicesController < ApplicationController
  before_action :set_cindex, only: [:show, :edit, :update, :destroy]

  # GET /cindices
  # GET /cindices.json
  def index
    @cindices = Cindex.all
  end

  # GET /cindices/1
  # GET /cindices/1.json
  def show
  end

  # GET /cindices/new
  def new
    @cindex = Cindex.new
  end

  # GET /cindices/1/edit
  def edit
  end

  # POST /cindices
  # POST /cindices.json
  def create
    @cindex = Cindex.new(cindex_params)

    respond_to do |format|
      if @cindex.save
        format.html { redirect_to @cindex, notice: 'Cindex was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cindex }
      else
        format.html { render action: 'new' }
        format.json { render json: @cindex.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cindices/1
  # PATCH/PUT /cindices/1.json
  def update
    respond_to do |format|
      if @cindex.update(cindex_params)
        format.html { redirect_to @cindex, notice: 'Cindex was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cindex.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cindices/1
  # DELETE /cindices/1.json
  def destroy
    @cindex.destroy
    respond_to do |format|
      format.html { redirect_to cindices_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cindex
      @cindex = Cindex.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cindex_params
      params[:cindex]
    end
end
