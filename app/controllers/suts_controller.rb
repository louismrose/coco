class SutsController < ApplicationController
  respond_to :html
  
  def index
    @suts = Sut.all
  end

  def show
    @sut = Sut.find(params[:id])
    respond_with @sut
  end

  def new
    @sut = Sut.new
  end

  def create
    @sut = Sut.new
    @sut.metamodel = params[:sut][:metamodel].read
    @sut.transformation = params[:sut][:transformation].read
    
    if @sut.save
      redirect_to @sut
    else
      render action: 'new'
    end
  end
end
