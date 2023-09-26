# BLOG Community
https://blog-web-no66.onrender.com/

## Architecture diagram

![structure-diagram drawio](https://github.com/gareth-go/blog-website/assets/140365512/60cebd4f-5787-4932-9076-1395a2d5d215)


## Development Guideline
***Enviroment***:
- Ruby 2.7.8
- Rails 6.1.7.4
- Nodejs 14.19.3
  
***Step to set up this repository***:
1. Clone this repository and go to root folder
```sh
git clone https://github.com/gareth-go/blog-website.git
cd blog-website
```
2. Setup database connection
```yml
# ./config/database.yml
# change username and password to your local PostgrSQL account
default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see Rails configuration guide
  # https://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: sa
  password: 1408
```
3. Create and setup database
```sh
rake db:create
rake db:migrate
# If you want to seed database
rake db:seed
```
4. Install dependencies
```sh
yarn install
bundle install
```
5. To run this project in local you have to run the webpacker server and the Rails server in the same time
```sh
# Run the webpacker server
./bin/webpack-dev-server
```
```sh
# Run the Rails server
rails s
```
After you done all these step you can open http://localhost:3000/ in your browser to see the project.

***Directory structure***
```
/blog-website
├── app
│   ├── assets
│   │   ├── config
│   │   │   └── manifest.js
│   │   └── stylesheets
│   │       └── application.scss
│   ├── channels
│   │   ├── application_cable
│   │   │   ├── channel.rb
│   │   │   └── connection.rb
│   │   └── notifications_channel.rb
│   ├── controllers
│   │   ├── application_controller.rb
│   │   ├── comments_controller.rb
│   │   ├── concerns
│   │   ├── dashboard
│   │   │   ├── accounts_controller.rb
│   │   │   ├── posts_controller.rb
│   │   │   └── tags_controller.rb
│   │   ├── home_controller.rb
│   │   ├── notifications_controller.rb
│   │   ├── posts_controller.rb
│   │   ├── reactions_controller.rb
│   │   ├── settings
│   │   │   ├── password_controller.rb
│   │   │   └── profile_controller.rb
│   │   ├── tags_controller.rb
│   │   └── users_controller.rb
│   ├── helpers
│   │   ├── application_helper.rb
│   │   ├── comments_helper.rb
│   │   ├── dashboard
│   │   │   ├── accounts_helper.rb
│   │   │   ├── dashboard_helper.rb
│   │   │   ├── posts_helper.rb
│   │   │   └── tags_helper.rb
│   │   ├── home_helper.rb
│   │   ├── notifications_helper.rb
│   │   ├── posts_helper.rb
│   │   ├── reactions_helper.rb
│   │   ├── settings
│   │   │   ├── password_helper.rb
│   │   │   └── profile_helper.rb
│   │   ├── tags_helper.rb
│   │   └── users_helper.rb
│   ├── javascript
│   │   ├── application.js
│   │   ├── channels
│   │   │   ├── consumer.js
│   │   │   ├── index.js
│   │   │   └── notifications_channel.js
│   │   ├── controllers
│   │   │   ├── application.js
│   │   │   ├── dashboard
│   │   │   │   └── accounts_controller.js
│   │   │   ├── dashboard_tags_controller.js
│   │   │   ├── hello_controller.js
│   │   │   ├── home_controller.js
│   │   │   ├── index.js
│   │   │   ├── notifications_controller.js
│   │   │   └── posts_controller.js
│   │   ├── images
│   │   │   ├── add-reaction-active-icon.svg
│   │   │   ├── add-reaction-icon.svg
│   │   │   ├── avatar.png
│   │   │   ├── comment-icon.svg
│   │   │   ├── comment-light-icon.svg
│   │   │   ├── contact-icon.svg
│   │   │   ├── exploding_head-icon.svg
│   │   │   ├── fire-icon.svg
│   │   │   ├── home-icon.svg
│   │   │   ├── like-icon.svg
│   │   │   ├── option-icon.svg
│   │   │   ├── post-icon.svg
│   │   │   ├── raised_hand-icon.svg
│   │   │   ├── tags-icon.svg
│   │   │   └── unicorn-icon.svg
│   │   ├── packs
│   │   │   ├── application.js
│   │   │   ├── create_post.js
│   │   │   ├── edit_post.js
│   │   │   ├── home.js
│   │   │   └── post.js
│   │   └── stylesheets
│   │       ├── application.scss
│   │       ├── create_post.scss
│   │       ├── dashboard.scss
│   │       ├── home.scss
│   │       └── post.scss
│   ├── jobs
│   │   └── application_job.rb
│   ├── mailers
│   │   └── application_mailer.rb
│   ├── models
│   │   ├── application_record.rb
│   │   ├── comment.rb
│   │   ├── concerns
│   │   ├── notification.rb
│   │   ├── post.rb
│   │   ├── post_tag.rb
│   │   ├── reaction.rb
│   │   ├── tag.rb
│   │   └── user.rb
│   ├── policies
│   │   ├── application_policy.rb
│   │   ├── comment_policy.rb
│   │   ├── dashboard
│   │   │   ├── tag_policy.rb
│   │   │   └── user_policy.rb
│   │   ├── post_policy.rb
│   │   └── settings
│   │       └── user_policy.rb
│   ├── services
│   │   ├── accounts
│   │   │   └── accounts_filter_service.rb
│   │   ├── application_service.rb
│   │   ├── notifications
│   │   │   └── create_notification_service.rb
│   │   └── posts
│   │       └── list_posts_service.rb
│   └── views
│       ├── active_storage
│       │   └── blobs
│       │       └── _blob.html.erb
│       ├── comments
│       │   ├── _comment.html.slim
│       │   ├── _comment_menu.html.slim
│       │   ├── create.js.erb
│       │   ├── destroy.erb
│       │   ├── _reply_comments.html.slim
│       │   ├── _reply.html.slim
│       │   ├── _reply_menu.html.slim
│       │   ├── _reply_option.html.slim
│       │   └── update.js.erb
│       ├── dashboard
│       │   ├── accounts
│       │   │   ├── _account.html.slim
│       │   │   ├── _actions.html.slim
│       │   │   ├── index.html.slim
│       │   │   ├── index.js.erb
│       │   │   ├── _list_accounts.html.slim
│       │   │   ├── next_page.js.erb
│       │   │   └── update.js.erb
│       │   ├── posts
│       │   │   ├── index.html.slim
│       │   │   └── index.js.erb
│       │   ├── _sidebar.html.slim
│       │   └── tags
│       │       ├── create.js.erb
│       │       ├── destroy.js.erb
│       │       ├── index.html.slim
│       │       ├── _tag.html.slim
│       │       └── update.js.erb
│       ├── devise
│       │   ├── confirmations
│       │   │   └── new.html.slim
│       │   ├── mailer
│       │   │   ├── confirmation_instructions.html.slim
│       │   │   ├── email_changed.html.slim
│       │   │   ├── password_change.html.slim
│       │   │   ├── reset_password_instructions.html.slim
│       │   │   └── unlock_instructions.html.slim
│       │   ├── passwords
│       │   │   ├── edit.html.slim
│       │   │   └── new.html.slim
│       │   ├── registrations
│       │   │   ├── edit.html.slim
│       │   │   └── new.html.slim
│       │   ├── sessions
│       │   │   └── new.html.slim
│       │   ├── shared
│       │   │   ├── _error_messages.html.slim
│       │   │   └── _links.html.slim
│       │   └── unlocks
│       │       └── new.html.slim
│       ├── home
│       │   ├── index.html.slim
│       │   └── index.js.erb
│       ├── layouts
│       │   ├── application.html.slim
│       │   ├── mailer.html.slim
│       │   └── mailer.text.slim
│       ├── notifications
│       │   ├── _alert.html.slim
│       │   ├── _alert_message.html.slim
│       │   ├── index.html.slim
│       │   ├── index.js.erb
│       │   ├── _list_notifications.html.slim
│       │   ├── _notification.html.slim
│       │   └── _sidebar.html.slim
│       ├── posts
│       │   ├── edit.html.slim
│       │   ├── new.html.slim
│       │   ├── _post_comments.html.slim
│       │   ├── _reaction.html.slim
│       │   ├── _reactions.html.slim
│       │   └── show.html.slim
│       ├── reactions
│       │   ├── create.js.erb
│       │   ├── destroy.js.erb
│       │   ├── _post_reactions.html.slim
│       │   ├── _reaction_type.html.slim
│       │   └── update.js.erb
│       ├── settings
│       │   ├── password
│       │   │   └── edit.html.slim
│       │   ├── profile
│       │   │   └── edit.html.slim
│       │   └── _sidebar.html.slim
│       ├── shared
│       │   ├── _list_posts.html.slim
│       │   ├── _navbar.html.slim
│       │   ├── page_not_found.html.slim
│       │   ├── _post_tags_link.html.slim
│       │   ├── _post_username_link.html.slim
│       │   ├── _reactions.html.slim
│       │   └── _side_menu.html.slim
│       ├── tags
│       │   ├── index.html.slim
│       │   ├── show.html.slim
│       │   └── show.js.erb
│       └── users
│           └── show.html.slim
├── babel.config.js
├── bin
│   ├── bundle
│   ├── rails
│   ├── rake
│   ├── render-build.sh
│   ├── setup
│   ├── spring
│   ├── webpack
│   ├── webpack-dev-server
│   └── yarn
├── config
│   ├── application.rb
│   ├── boot.rb
│   ├── cable.yml
│   ├── credentials.yml.enc
│   ├── database.yml
│   ├── environment.rb
│   ├── environments
│   │   ├── development.rb
│   │   ├── production.rb
│   │   └── test.rb
│   ├── importmap.rb
│   ├── initializers
│   │   ├── application_controller_renderer.rb
│   │   ├── assets.rb
│   │   ├── backtrace_silencers.rb
│   │   ├── content_security_policy.rb
│   │   ├── cookies_serializer.rb
│   │   ├── devise.rb
│   │   ├── filter_parameter_logging.rb
│   │   ├── inflections.rb
│   │   ├── mime_types.rb
│   │   ├── pagy.rb
│   │   ├── permissions_policy.rb
│   │   └── wrap_parameters.rb
│   ├── locales
│   │   ├── devise.en.yml
│   │   └── en.yml
│   ├── master.key
│   ├── puma.rb
│   ├── routes.rb
│   ├── spring.rb
│   ├── storage.yml
│   ├── webpack
│   │   ├── development.js
│   │   ├── environment.js
│   │   ├── loaders
│   │   │   └── jquery.js
│   │   ├── production.js
│   │   └── test.js
│   └── webpacker.yml
├── config.ru
├── db
│   ├── migrate
│   │   ├── 20230808064428_create_users.rb
│   │   ├── 20230808064648_create_tags.rb
│   │   ├── 20230808065047_create_posts.rb
│   │   ├── 20230808065712_create_post_tags.rb
│   │   ├── 20230808070621_create_reactions.rb
│   │   ├── 20230808071020_create_comments.rb
│   │   ├── 20230808071332_create_notifications.rb
│   │   ├── 20230808082311_add_devise_to_users.rb
│   │   ├── 20230810084623_create_active_storage_tables.active_storage.rb
│   │   ├── 20230810084624_create_action_text_tables.action_text.rb
│   │   ├── 20230821084430_add_comments_count_to_posts_and_comments.rb
│   │   ├── 20230823042522_refactor_relationship_comments_posts_replies.rb
│   │   ├── 20230823085229_add_replies_count_to_comments.rb
│   │   ├── 20230825084915_add_posts_count_to_tags.rb
│   │   ├── 20230828085358_add_comments_and_posts_count_to_users.rb
│   │   ├── 20230905051152_add_reactions_count_to_posts.rb
│   │   ├── 20230908071147_add_viewed_to_notifications.rb
│   │   ├── 20230911100200_add_created_at_to_notifications.rb
│   │   └── 20230921043656_add_default_value_for_counter.rb
│   ├── schema.rb
│   └── seeds.rb
├── Gemfile
├── Gemfile.lock
├── lib
│   ├── assets
│   └── tasks
├── package.json
├── postcss.config.js
├── public
│   ├── 404.html
│   ├── 422.html
│   ├── 500.html
│   ├── apple-touch-icon.png
│   ├── apple-touch-icon-precomposed.png
│   ├── favicon.ico
│   └── robots.txt
├── Rakefile
├── README.md
├── rubocop.yml
├── spec
│   ├── controllers
│   │   ├── comments_controller_spec.rb
│   │   ├── dashboard
│   │   │   ├── accounts_controller_spec.rb
│   │   │   └── tags_controller_spec.rb
│   │   ├── posts_controller_spec.rb
│   │   ├── reactions_controller_spec.rb
│   │   ├── settings
│   │   │   ├── password_controller_spec.rb
│   │   │   └── profile_controller_spec.rb
│   │   ├── tags_controller_spec.rb
│   │   └── users_controller_spec.rb
│   ├── factories
│   │   ├── comments.rb
│   │   ├── posts.rb
│   │   ├── reactions.rb
│   │   ├── tags.rb
│   │   └── users.rb
│   ├── models
│   │   ├── comment_spec.rb
│   │   ├── post_spec.rb
│   │   ├── reaction_spec.rb
│   │   ├── tag_spec.rb
│   │   └── user_spec.rb
│   ├── rails_helper.rb
│   ├── spec_helper.rb
│   └── support
│       └── authentication.rb
├── test
│   ├── application_system_test_case.rb
│   ├── channels
│   │   ├── application_cable
│   │   │   └── connection_test.rb
│   │   └── notifications_channel_test.rb
│   ├── controllers
│   │   ├── comments_controller_test.rb
│   │   ├── dashboard
│   │   │   ├── accounts_controller_test.rb
│   │   │   ├── posts_controller_test.rb
│   │   │   └── tags_controller_test.rb
│   │   ├── home_controller_test.rb
│   │   ├── notifications_controller_test.rb
│   │   ├── posts_controller_test.rb
│   │   ├── reactions_controller_test.rb
│   │   ├── settings
│   │   │   ├── password_controller_test.rb
│   │   │   └── profile_controller_test.rb
│   │   ├── tags_controller_test.rb
│   │   └── users_controller_test.rb
│   ├── fixtures
│   │   ├── action_text
│   │   │   └── rich_texts.yml
│   │   ├── comments.yml
│   │   ├── files
│   │   ├── notifications.yml
│   │   ├── posts.yml
│   │   ├── post_tags.yml
│   │   ├── reactions.yml
│   │   ├── tags.yml
│   │   └── users.yml
│   ├── helpers
│   ├── integration
│   ├── mailers
│   ├── models
│   │   ├── comment_test.rb
│   │   ├── notification_test.rb
│   │   ├── post_tag_test.rb
│   │   ├── post_test.rb
│   │   ├── reaction_test.rb
│   │   ├── tag_test.rb
│   │   └── user_test.rb
│   ├── policies
│   │   ├── comment_policy_test.rb
│   │   ├── dashboard
│   │   │   ├── tag_policy_test.rb
│   │   │   └── user_policy_test.rb
│   │   └── post_policy_test.rb
│   ├── system
│   └── test_helper.rb
├── vendor
└── yarn.lock
```


## Database Diagram
![image](https://github.com/gareth-go/blog-website/assets/140365512/203aafaf-5d9b-4193-870d-728a8c75e58a)
