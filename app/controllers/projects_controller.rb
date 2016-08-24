class ProjectsController < ApplicationController
      before_action :set_project, only: [:show, :edit, :update, :destroy]
      
    # GET /projects
    # GET /projects.json   
    def index
    @projects = Project.where("user_id = ?",current_user.id).order("created_at DESC")
    end
  
  
    # POST /projects
    # POST /projects.json
    def create
    @project = Project.new(project_params)
    @project.user_id=current_user.id

    respond_to do |format|
      
      if @project.save
        format.html { redirect_to @project}
        format.json { render :show, status: :created, location: @project }
        format.js
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        format.js
      end
    end
    
    end 
    
    # DELETE /projects/1
    # DELETE /projects/1.json
    def destroy
    @project.task.each do |task|
    task.destroy
    end
    
    @project.destroy
    @project_id=@project.id
   
    respond_to do |format|
      format.html { redirect_to root_url}
      format.json { head :no_content }
      format.js
    end
    
    end
    

    # PATCH/PUT /projects/1
    # PATCH/PUT /projects/1.json
    def update
      
    @project_id=@project.id
    
    respond_to do |format|
      if @project.update(project_params)
        @projects = Project.where("user_id = ?",current_user.id)
        format.html { redirect_to @project}
        format.json { render :show, status: :ok, location: @project }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        format.js
      end
    end
      
    end
    
  # PUT /projects/priority
	 def priority
	    #pp params[:each]
	    params[:order].each do |key,value|
      Task.find(value[:id]).update_attribute(:priority,value[:position])
    end
     render :nothing => true
	end    
    
    private
    
    def set_project
      @project = Project.find(params[:id])
    end
    
     def project_params
      params.require(:project).permit(:name)
    end

end
