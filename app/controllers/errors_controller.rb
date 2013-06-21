class ErrorsController < ApplicationController
  respond_to :html
  
  before_action :set_transformation
  
  def index
    @errors = Error.all_for(@transformation)
    respond_with(@transformation, @errors)
  end
  
private
  def set_transformation
    @transformation = Transformation.find(params[:transformation_id])
  end
end