class TransformationsController < ApplicationController
  respond_to :html
  
  def index
    @transformations = Transformation.all
    respond_with(@transformations)
  end

  def show
    @transformation = Transformation.find(params[:id])
    respond_with(@transformation)
  end
end