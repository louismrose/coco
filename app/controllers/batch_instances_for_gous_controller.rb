require "gous/translates_gous_to_hutn"

class BatchInstancesForGousController < ApplicationController
  before_action :set_transformation

  def create
    @instances = batch_gous_params[:instances].map do |n, gous_params|
      hutn = TranslatesGousToHutn.new(gous_params[:symbols], gous_params[:variables]).run
      @instance = @transformation.instances.create(input_model: hutn)
      Resque.enqueue(InstanceRunner, @instance.id) if @instance.save
      @instance
    end
    
    render json: { instances: @instances.map {|i| json_for(i) } }
  end
  
private
  def json_for(i)
    {
      id: i.id,
      coverage_url: url_for([@transformation, i]) + ".gous.json",
      input_model: i.input_model
    }
  end

  def set_transformation
    @transformation = Transformation.find(params[:transformation_id])
  end

  def batch_gous_params
    params.permit!
  end
end