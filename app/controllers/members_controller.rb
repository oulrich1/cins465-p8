class MembersController < ApplicationController
  before_filter :authenticate_member! # current_member
  before_action :set_member, only: [:show, :edit, :update, :destroy]

# in the forms we need this association??
# <%= f.association :members %>

  # GET /members
  # GET /members.json
  def index
    @members = Member.all
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/project_managers
  def show_all_project_managers
    @members = Member.where("is_project_manager = 'on'")
  end

  # GET /members/:id/my_project_managers
  def show_my_project_managers
    @managers = Member
      .select("members.*")
      .joins("right outer join member_project_groupings as MPG on MPG.m_id = #{current_member.id}")
      .joins("right outer join projects on projects.id = MPG.p_id")
      .where("members.id is not NULL");
  end
  
  def show_deadlines
    @deadlines = Deadline.select("*").where("deadlines.m_id = #{current_member.id}")
  end

  def show_projects
    
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
      # type = "member"

    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render action: 'show', status: :created, location: @member }
      else
        format.html { render action: 'new' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end

  def is_project_manager
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :email, :type, :is_project_manager)
    end

    def update_params
       params.require(:member).permit(:name, :email, :type, :is_project_manager)
    end


end
