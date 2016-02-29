class SubscriberMailer < ApplicationMailer
  default from: 'notifications@blogger-hp.herokuapp.com'
  
  def notify(subscriber, article, user)
    @subscriber = subscriber
    @article = article
    @user = user
    mail to: subscriber.email, subject: "New article by #{user.name}"
  end
end
