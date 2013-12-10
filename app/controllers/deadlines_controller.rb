class DeadlinesController < ApplicationController
  before_action :set_deadline, only: [:show, :edit, :update, :destroy]

  # GET /deadlines
  # GET /deadlines.json
  def index
    @deadlines = Deadline.all
  end

  # GET /deadlines/1
  # GET /deadlines/1.json
  def show
    @deadline = Deadline.find(params[:id])
    @deadline_members = Member.where("id in(select m_id from member_deadline_groupings)")
  end

  # GET /deadlines/new
  def new
    @project  = Project.find(params[:id])
    @deadline = Deadline.new
  end

  # GET /deadlines/1/edit
  def edit
  end

  def append_member
    @project  = Project.find(params[:p_id])
    @deadline  = Deadline.find(params[:d_id])
    # continue to view..
  end

  def apply_deadline_to_members
    @project  = Project.find(params[:p_id])
    @deadline  = Deadline.find(params[:d_id])

    tuple = {   
                m_id: 0, 
                p_id: @project.id.to_s, 
                title: @deadline.title, 
                description: @deadline.description, 
                due_date: @deadline.due_date
            }

    members_to_add = params[:deadline]
    members_to_add.each do |pair|
        tuple[:m_id] = pair[0];
        save_member_project_deadline(tuple)
    end

    redirect_to @project
  end

    def save_member_project_deadline(tuple)  
      if MemberDeadlineGroupings.new({m_id: tuple[:m_id], d_id: @deadline.id}).save()
        puts("Successfully Saved new deadline association: ")
      else
        puts("Failed to Save new deadline associationw/ m_id: "\
                  + id.to_s + ", p_id: " + @project.id)
      end
    end

  # POST /deadlines
  # POST /deadlines.json
  def create
    @deadline = Deadline.new(deadline_params)
    

    respond_to do |format|
      if @deadline.save
        MemberDeadlineGroupings.new({m_id: @deadline.m_id, d_id: @deadline.id}).save()

        format.html { redirect_to "/projects/#{deadline_params['p_id']}", notice: 'Deadline was successfully created.' }
        format.json { render action: 'show', status: :created, location: @deadline }
      else
        format.html { render action: 'new' }
        format.json { render json: @deadline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deadlines/1
  # PATCH/PUT /deadlines/1.json
  def update
    respond_to do |format|
      if @deadline.update(deadline_params)
        format.html { redirect_to @deadline, notice: 'Deadline was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @deadline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deadlines/1
  # DELETE /deadlines/1.json
  def destroy
    @deadline.destroy
    respond_to do |format|
      format.html { redirect_to deadlines_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deadline
      puts "------------------------------"
      @deadline = Deadline.find(params[:id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deadline_params
      params.require(:deadline).permit(:title, :m_id, :p_id, :description, :due_date, :members_to_add)
    end
end
