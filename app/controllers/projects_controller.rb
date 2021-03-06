class ProjectsController < ApplicationController
  include ProjectsHelper

  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save

        save_member_project_relation({m_id: current_member.id.to_s, p_id: @project.id.to_s})

        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET   /projects/1/show_members
  # .. show members to select from them
  def show_members
    @project = Project.find(params[:id])
    @members = 
    Member.select("*")
      .where("id not in (select MPG.m_id from member_project_groupings as MPG where MPG.p_id = #{@project.id})")
        # .joins("left outer join members as M on M.id != member_project_groupings.m_id")
      #select M.* from (select * from members) as M where id not in 
      #(select MPG.m_id from member_project_groupings as MPG where MPG.p_id = 3); 
  end



  # POST/PATCH /projects/1/add_members
  def add_members
    @project = Project.find(params[:id])
    save_members

    # access the data from members
    # where the member id is the same 
    # Select * from members
    # left inner Join member_project_groupings
    # on members.id = member_project_groupings.m_id
    # where member_project_groupings.p_id = 0;

    redirect_to @project
  end

  # GET
  def remove_members
    @members = Member.all
    @project = Project.find(params[:id])
  end

  # POST/PUT
  def delete_members
    @project = Project.find(params[:id])

    member_ids = params[:project] # returns an array of key value pairs (m_id => p_id)
    member_ids.each do |pair|
      MemberProjectGrouping.where("m_id = #{pair[0]} and p_id = #{@project.id}").destroy_all
    end
    
    redirect_to @project
  end

  # GET /projects/:id/deadline/new
  def new_deadline
    
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)

        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    def save_members
      # get the list of member ids
      member_ids = params[:project]
      #log_test(member_ids);

      # add the members with ids in member_ids:
      # to the groupings table.. "member_project_groupings"
      # That table is the intermediary reference table between
      #    members and projects:
      # => members have many projects
      # => projects have many members
      member_ids.each{ 
        |pair|
        tuple = {m_id: pair[0], p_id: @project.id.to_s}
        save_member_project_relation(tuple)
      }
    end

    def save_member_project_relation(tuple)
      if MemberProjectGrouping.find_by(tuple)
        log_test("Warning: grouping already exists! " + tuple.to_s)
      else 
        grouping = MemberProjectGrouping.new(tuple)
        if grouping.save
          log_test("Successfully Saved new MemberProjectGrouping: " + grouping.to_s)
        else
          log_test("Failed to Save new MemberProjectGrouping w/ m_id: "\
                    + id.to_s + ", p_id: " + @project.id)
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :expected_due_date, :manager_id, :url)
    end
end
