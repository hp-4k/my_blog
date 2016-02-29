require "rails_helper"

RSpec.describe SubscriberMailer, type: :mailer do
  
  describe '#notify' do
    
    before :each do
      @user = create(:user)
      @article = @user.articles.create(attributes_for(:article))
      @subscriber = @user.subscribers.create(attributes_for(:subscriber))
      @mail = SubscriberMailer.notify(@subscriber, @article, @user)
    end
    
    it "renders the correct subject" do
      expect(@mail.subject).to eq "New article by #{@user.name}"
    end
    
    it "sends the email to the subscriber" do
      expect(@mail.to).to eq [@subscriber.email]
    end
    
    it "sends the email from a correct address" do
      expect(@mail.from).to eq ['notifications@blogger-hp.herokuapp.com']
    end
    
    it "includes a link to the article" do
      expect(@mail.body.encoded).to match article_url(@article.slug)
    end
    
    it "includes a link to unsubscribe" do
      expect(@mail.body.encoded).to match @subscriber.unsubscribe_token
    end
    
  end
  
end

# tests for corresponing sidekiq worker

RSpec.describe NotificationsWorker, type: :mailer do
  
  before :each do
    @worker = NotificationsWorker.new
    @user = create(:user) do |user|
      user.subscribers.create(email: 'first@example.com')
      user.subscribers.create(email: 'second@example.com')
    end
  end
  
  it "sends emails to all recipients" do
    article = @user.articles.create(attributes_for(:article))
    expect { @worker.perform(article.id) }
      .to change { ActionMailer::Base.deliveries.count }.by(2)
  end
  
end
