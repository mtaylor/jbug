class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:id])

    current_user.friends << friend

    if current_user.save
      flash[:notice] = "Friend Added"
    else
      flash[:error] = "Unable to add friend"
    end
    redirect_to root_path
  end

  def destroy
    current_user.friends.delete(current_user.friends.find(params[:id]))

    if current_user.save
      flash[:notice] = "Friend Removed"
    else
      flash[:error] = "Unable to remove friend"
    end
    redirect_to root_path
  end

end
