require "gous/translates_gous_to_hutn"

class InstancesForGousController < ApplicationController
  before_action :set_transformation

  def create
    hutn = TranslatesGousToHutn.new(gous_params[:symbols], gous_params[:variables]).run
    @instance = @transformation.instances.create(input_model: hutn)
    Resque.enqueue(InstanceRunner, @instance.id) if @instance.save
    
    render json: {
      id: @instance.id,
      coverage_url: url_for([@transformation, @instance]) + ".gous.json",input_model: @instance.input_model,
      input_model: @instance.input_model
    }
  end

  def show
    @instance = Instance.find(params[:id])

    render json: {  
      id: @instance.id,
      coverage: @instance.coverage,
      output_model: @instance.output_model
    }
  end
  
private
  def set_transformation
    @transformation = Transformation.find(params[:transformation_id])
  end

  def gous_params
    params.permit!
  end
end