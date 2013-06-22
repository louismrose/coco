require "gous/translates_gous_to_hutn"

class InstancesForGousController < ApplicationController
  before_action :set_transformation

  def create
    hutn = TranslatesGousToHutn.new(gous_params[:symbols], gous_params[:variables]).run
    @instance = @transformation.instances.create(input_model: hutn)
    Resque.enqueue(InstanceRunner, @instance.id) if @instance.save
    
    render json: {
      id: @instance.id,
      coverage_url: url_for([@transformation, @instance]) + ".gous.json",
      input_model: @instance.input_model
    }
  end

  def show
    @instance = Instance.find(params[:id])

    coverage = if @instance.coverage then @instance.coverage.split(" ").map(&:to_i) else nil end

    render json: {  
      id: @instance.id,
      coverage: coverage,
      error: @instance.error,
      output_model: @instance.output_model
    }
  end
  
private
  def set_transformation
    @transformation = Transformation.find_by_id_or_name(params[:transformation_id])
  end

  def gous_params
    params.permit!
  end
end