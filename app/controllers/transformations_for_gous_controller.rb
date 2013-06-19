class TransformationsForGousController < ApplicationController
  respond_to :json
  
  def show
    @transformation = Transformation.find(params[:id])
    
    render json: {
      grammar: File.read(File.join(Rails.root, @transformation.grammar_file)),
      evaluation_url: new_transformation_instance_for_gous_url(@transformation)
    }
  end
end