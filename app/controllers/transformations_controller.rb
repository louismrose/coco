class TransformationsController < ApplicationController
  respond_to :html

  def show
    @transformation = Transformation.find(params[:id])
  end
end