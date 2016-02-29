# Blogger

Live version deployed to Heroku can be accessed at http://blogger-hp.herokuapp.com

This application is a simple blogging website implementing the following features:

* a user can sign up to start a blog
* users can create, edit and delete their own blog posts using the user interface
* links to blog posts and users' sites are SEO friendly
* blogs posts support [Markdown](https://daringfireball.net/projects/markdown/)
* visitors can add comments
* users can delete comments under their articles
* visitors can subscribe to user's blog
* visitors will be sent an email every time the user creates a new post
* the emails contain a link to the new post and a link to unsubscribe

Technicalities:
* passwords stored with `has_secure_password`
* simple authentication based on `session`
* emails are sent asynchronously with sidekiq and SendGrid
* basic front-end with elementary Bootstrap