class InstancesController < ApplicationController
  respond_to :html, :json
  
  before_action :set_transformation

  def new
    @instance = @transformation.instances.build
    respond_with(@transformation, @instance)
  end

  def create
    @instance = @transformation.instances.create(instance_params)
    Resque.enqueue(InstanceRunner, @instance.id) if @instance.save
    respond_with(@transformation, @instance)
  end

  def show
    @instance = Instance.find(params[:id])
    respond_with(@transformation, @instance)
  end
  
private
  def set_transformation
    @transformation = Transformation.find(params[:transformation_id])
  end

  def instance_params
    params.require(:instance).permit(:input_model)
  end
end