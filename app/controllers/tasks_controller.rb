class TasksController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end


  # GET /tasks
  # GET /tasks.json

  def index
    if params[:all_tasks]
      @tasks = @project.tasks.order(params[:sort])
      @booly = false
    else
      @tasks = @project.tasks.where(complete: false).order(params[:sort])
      @booly = true
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = @project.tasks.find(params[:id])
  end

  # GET /tasks/new
  def new
    @task = @project.tasks.new
  end

  # GET /tasks/1/edit
  def edit
    @task = @project.tasks.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @project.tasks.new(task_params)
      if @task.save
        redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @task = @project.tasks.find(params[:id])
      if @task.update(task_params)
        redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy

    # if @tasks = Task.order(params[:sort])
    if project_tasks_path(@project, params[:incomplete])
      redirect_to project_tasks_path(@project, incomplete: "Incomplete" ), notice: 'Task was successfully destroyed.'
    else
      redirect_to project_tasks_path(@project, all_task: "All tasks" ), notice: 'Task was successfully destroyed.'
    end
    # elsif @tasks = Task.where(complete: false).order(params[:sort])
    #   redirect_to tasks_path(incomplete: "Incomplete"), notice: 'Task was successfully destroyed.'
    # else
    #   redirect_to tasks_path(all_task: "All tasks" ), notice: 'Task was successfully destroyed.'
    # end

  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :complete, :date)
    end
end
