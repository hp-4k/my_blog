class SubscribersController < ApplicationController
  
  def create
    user = User.friendly.find(params[:user])
    subscriber = user.subscribers.new(subscriber_params)
    if subscriber.save
      flash[:success] = "#{params[:subscriber][:email]} added to the subscriber list."
    else
      flash[:warning] = subscriber.errors.full_messages.first + '.'
    end
    redirect_to :back
  end
  
  def unsubscribe
    subscriber = Subscriber.find(params[:id])
    if subscriber.unsubscribe_token == params[:token]
      subscriber.destroy
      flash[:success] = 'You will no longer receive notifications from this user.'
      redirect_to root_url
    else
      flash[:danger] = 'Invalid unsubscribe link.'
      redirect_to root_url
    end
  end
  
  private
  
    def subscriber_params
      params.require(:subscriber).permit(:email)
    end
  
end
