class WishlistItemsController < ApplicationController
  def create
    @wishlistitem = WishlistItem.new(wishlist_items_params)
    if @wishlistitem.save
      flash['success'] = 'saved'
      redirect_to wishlists_path
    else
      redirect_to checkins_path
    end
  end

  def destroy
    @wishlistitem = WishlistItem.find(params[:id])
    @wishlistitem.destroy
    flash['notice'] = 'The item was deleted successfully'
    redirect_to wishlists_path
  end

  private

  def wishlist_items_params
    params.require(:wishlist_item).permit(:wishlist_id, :name, :photo_url,
                                          :address)
  end
end
