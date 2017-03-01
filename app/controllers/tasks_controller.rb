class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, except: [:create]

  def create
	  @task = @project.task.create(task_params)
    respond_to do |format|
      format.html{redirect_to @project, @task}
      format.js
    end
  end
	
	def destroy
    if @task.destroy
      respond_to do |format|
        format.html{ redirect_to @project}
        format.js
      end 
    end  
	end
	
	def update 
	  @tasks = Task.all
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @project}
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end 
	end    
    
  def complete
    @task.update_attribute(:status, 1)
		
		respond_to do |format|
      format.html{ redirect_to @project}
      format.js
    end
  end
	
	private
  def set_project
		@project = Project.where("user_id = ?", current_user.id).find(params[:project_id])
	end
	
	def set_task
		@task = @project.task.find(params[:id])
	end
	
	def task_params
		params[:task].permit(:name, :deadline)
	end
end
