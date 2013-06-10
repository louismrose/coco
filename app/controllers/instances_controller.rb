class InstancesController < ApplicationController
  respond_to :html
  
  before_action :set_transformation

  def new
    @instance = @transformation.instances.build
  end

  def create
    @instance = @transformation.instances.create(instance_params)

    if @instance.save
      Resque.enqueue(InstanceRunner, @instance.id)
      redirect_to [@transformation,@instance], notice: 'Instance was successfully created.'
    else
      render action: 'new'
    end
  end

  def show
    @instance = Instance.find(params[:id])
  end
  
private
  def set_transformation
    @transformation = Transformation.find(params[:transformation_id])
  end

  def instance_params
    params.require(:instance).permit(:input_model)
  end
end