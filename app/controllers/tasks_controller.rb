class TasksController < ApplicationController
    before_action :set_project
    before_action :set_task, except: [:create]
    
    # POST   /projects/:project_id/tasks
    # POST   /projects/:project_id/tasks.json
  def create
	@task = @project.task.create(task_params)
	
	@project_id = @project.id
    
    respond_to do |format|
      format.html{redirect_to @project, @task}
      format.js
    end
    
	end
	
	
	#DELETE /projects/:project_id/tasks/:id
	#DELETE /projects/:project_id/tasks/:id.json
	def destroy
	@task = @project.task.find(params[:id])
	@task_id = @task.id
  @task.destroy
      
    respond_to do |format|
      format.html{ redirect_to @project}
      format.js
    end  
	    
	end
	
	#PATCH /projects/:project_id/tasks/:id
	#PATCH /projects/:project_id/tasks/:id.json
	
	def update 
	 
	  @tasks = Task.all
	  @project_id = @project.id
   
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
    
  # PATCH /projects/:project_id/tasks/:id/complete
  def complete
    @task.update_attribute(:status, 1)
		
		respond_to do |format|
      format.html{ redirect_to @project}
      format.js
    end
	end
	

    private
    
    def set_project
		@project = Project.find(params[:project_id])
	end
	
	def set_task
		@task = @project.task.find(params[:id])
	end
	
	def task_params
		params[:task].permit(:name, :deadline)
	end
    
end
