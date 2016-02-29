class NotificationsWorker
  include Sidekiq::Worker
  
  def perform(article_id)
    # sends emails to all subscribers of the given article's author
    article = Article.find(article_id)
    user = article.user
    user.subscribers.each do |subscriber|
      logger.info 'sending email'
      SubscriberMailer.notify(subscriber, article, user).deliver_now
    end
  end
end