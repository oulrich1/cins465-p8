class MemberProjectGroupingsController < ApplicationController
  before_action :set_member_project_grouping, only: [:show, :edit, :update, :destroy]

  # GET /member_project_groupings
  # GET /member_project_groupings.json
  def index
    @member_project_groupings = MemberProjectGrouping.all
  end

  # GET /member_project_groupings/1
  # GET /member_project_groupings/1.json
  def show
  end

  # GET /member_project_groupings/new
  def new
    @member_project_grouping = MemberProjectGrouping.new
  end

  # GET /member_project_groupings/1/edit
  def edit
  end

  # POST /member_project_groupings
  # POST /member_project_groupings.json
  def create
    @member_project_grouping = MemberProjectGrouping.new(member_project_grouping_params)

    respond_to do |format|
      if @member_project_grouping.save
        format.html { redirect_to @member_project_grouping, notice: 'Member project grouping was successfully created.' }
        format.json { render action: 'show', status: :created, location: @member_project_grouping }
      else
        format.html { render action: 'new' }
        format.json { render json: @member_project_grouping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /member_project_groupings/1
  # PATCH/PUT /member_project_groupings/1.json
  def update
    respond_to do |format|
      if @member_project_grouping.update(member_project_grouping_params)
        format.html { redirect_to @member_project_grouping, notice: 'Member project grouping was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @member_project_grouping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /member_project_groupings/1
  # DELETE /member_project_groupings/1.json
  def destroy
    @member_project_grouping.destroy
    respond_to do |format|
      format.html { redirect_to member_project_groupings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member_project_grouping
      @member_project_grouping = MemberProjectGrouping.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_project_grouping_params
      params.require(:member_project_grouping).permit(:id, :m_id, :p_id)
    end
end
