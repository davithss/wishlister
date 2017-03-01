class WishlistsController < ApplicationController

  def index
    @wishlists = Wishlist.all
  end

  def show
    @wishlist = Wishlist.find(params[:id])
  end

  def new
    @wishlist = Wishlist.new
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

  private

  def wishlist_params
    params.require(:wishlist).permit(:name)
  end
end
