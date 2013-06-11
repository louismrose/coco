class TransformationsController < ApplicationController
  respond_to :html

  def show
    @transformation = Transformation.find(params[:id])
    respond_with(@transformation)
  end
end