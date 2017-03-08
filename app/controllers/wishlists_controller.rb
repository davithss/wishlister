class WishlistsController < ApplicationController
  before_action :profile
  before_action :checkins

  def index
    @wishlists = Wishlist.all
  end

  def show
    @wishlist = Wishlist.find(params[:id])
  end

  def new
    @wishlist = Wishlist.new
    @wishlist.wishlist_items.build
  end

  def create
    @wishlist = Wishlist.new(wishlist_params)

    if @wishlist.save
      flash['notice'] = 'it was saved.'
      redirect_to wishlist_path(@wishlist)
    else
      render :new
    end
  end

  def edit
    @wishlist = Wishlist.find(params[:id])
  end

  def update
    @wishlist = Wishlist.find(params[:id])

    if @wishlist.update_attributes(wishlist_params)
      flash['notice'] = 'it was updated successfully'
      redirect_to wishlist_path(@wishlist)
    else
      render :edit
    end
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    @wishlist.destroy

    flash['notice'] = 'it was deleted successfully'
    redirect_to wishlists_path
  end

  def profile
    @profile = current_user.foursquare.user('self')
    @user_photo = "
              #{@profile['photo']['prefix']}40x40#{@profile['photo']['suffix']}"
  end

  def checkins
    @profile = current_user.foursquare.user('self')
    @user_photo = "
              #{@profile['photo']['prefix']}40x40#{@profile['photo']['suffix']}"
    @checkins = current_user.foursquare.recent_checkins(limit: '10')
  end

  private

  def wishlist_params
    params.require(:wishlist).permit(:name, wishlist_items_attributes:
                                            [:id, :name, :photo_url, :address,
                                             :wishlist_id, :_destroy])
  end
end
