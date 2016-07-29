class SubjectsController < ApplicationController
  
  layout false

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
  @subject = Subject.new({:name => "Default"})    
  end

  def create
    # instantiate a new objet using form a parameters
    #@subject = Subject.new(params.require(:subject).premit(:name, :position, :visible))  #strong parameters
    @subject = Subject.new(subject_params)
    # save the object
    if @subject.save
    # if save succeeds. redirect to the index action
      flash[:notice] = "Subject created successfully."
      redirect_to(:action => 'index')
    else
    # if save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

   def update
    # find an existing object using form parameters  
    @subject = Subject.find(params[:id])
    # update the object
    if @subject.update_attributes(subject_params)      
    # if update succeeds. redirect to the index action
      flash[:notice] = "Subject updated successfully."
      redirect_to(:action => 'show', :id => @subject.id)
    else
    # if update fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    #@subject = Subject.find(params[:id])
    #@subject.destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' destroyed successfully."
    redirect_to(:action => 'index')
  end

  private
    def subject_params
      #same as using "params[:subject]", except that it:
      #- raises an error if :subject is not present
      #- allows listed attributes to be mass-assigned
      params.require(:subject).permit(:name, :position, :visible)
    end
     
end
