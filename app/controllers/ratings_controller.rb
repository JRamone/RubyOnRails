class RatingsController < ApplicationController
  before_action :expire_fragments, only: [:create, :update, :destroy]

  def index
    @ratings = Rating.recent
    @most_active_users = User.most_active 3
    @best_beers = Beer.best_rated 3
    @best_breweries = Brewery.best_rated 3
    @best_styles = Style.best_rated 3
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.create params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user
    if @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end

  def expire_fragments
    expire_fragment('brewerylist')
  end
end
