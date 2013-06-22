class ErrorsController < ApplicationController
  respond_to :html
  
  before_action :set_transformation
  
  def index
    @errors = Error.all_for(@transformation)
    respond_with(@transformation, @errors)
  end
  
private
  def set_transformation
    @transformation = Transformation.find_by_id_or_name(params[:transformation_id])
  end
end