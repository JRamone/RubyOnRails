class BeersController < ApplicationController
  before_action :set_beer, only: %i[show edit update destroy]
  before_action :set_breweries_and_styles_for_template, only: [:new, :edit]
  before_action :ensure_that_signed_in, except: [:index, :show, :list]
  before_action :expire_fragments, only: [:create, :update, :destroy]
  # GET /beers or /beers.json
  def index
    @order = params[:order] || 'Name'
    return if request.format.html? && fragment_exist?("beerlist-#{@order}")

    @beers = Beer.includes(:brewery, :style, :ratings).all

    @beers = case @order
             when "Name" then @beers.sort_by(&:name)
             when "Brewery" then @beers.sort_by{ |b| b.brewery.name }
             when "Style" then @beers.sort_by{ |b| b.style.name }
             when "Rating" then @beers.sort_by(&:average_rating).reverse
             end
  end

  def list
  end

  # GET /beers/1 or /beers/1.json
  def show
    @rating = Rating.new
    @rating.beer = @beer
  end

  # GET /beers/new
  def new
    @beer = Beer.new
  end

  # GET /beers/1/edit
  def edit
  end

  # POST /beers or /beers.json
  def create
    %w(beerlist-name beerlist-brewery beerlist-style).each{ |f| expire_fragment(f) }
    @beer = Beer.new(beer_params)

    respond_to do |format|
      if @beer.save
        format.html { redirect_to beers_path, notice: "Beer was successfully created." }
        format.json { render :show, status: :created, location: @beer }
      else
        set_breweries_and_styles_for_template
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beers/1 or /beers/1.json
  def update
    %w(beerlist-name beerlist-brewery beerlist-style).each{ |f| expire_fragment(f) }
    respond_to do |format|
      if @beer.update(beer_params)
        format.html { redirect_to beer_url(@beer), notice: "Beer was successfully updated." }
        format.json { render :show, status: :ok, location: @beer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1 or /beers/1.json
  def destroy
    %w(beerlist-name beerlist-brewery beerlist-style).each{ |f| expire_fragment(f) }
    @beer.destroy

    respond_to do |format|
      format.html { redirect_to beers_url, notice: "Beer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_beer
    @beer = Beer.find(params[:id])
  end

  def set_breweries_and_styles_for_template
    @breweries = Brewery.all
    @styles = Style.all
  end

  def expire_fragments
    expire_fragment('brewerieslist')
  end

  # Only allow a list of trusted parameters through.
  def beer_params
    params.require(:beer).permit(:name, :style_id, :brewery_id, :order)
  end
end
