class KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      redirect_to @kitten, notice: "Kitten successfully created!"
    else
      render :new, status: :unprocessable_entity, alert: "Please try again, there was an error."
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update(kitten_params)
      redirect_to @kitten, notice: "Kitten has been successfully updated!"
    else
      render :edit, status: :unprocessable_entity, alert:  "Please try again, there was an error."
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    if @kitten.destroy
      redirect_to kittens_path, alert: "#{@kitten.name} was successfully deleted."
    else
      render :edit, status: :unprocessable_entity, alert:  "Please try again, there was an error."
    end
  end

  private

    def kitten_params
      params.expect(kitten: [ :name, :age, :cuteness, :softness ])
    end
end
