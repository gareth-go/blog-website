# BLOG Community

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


## Database Diagram
![image](https://github.com/gareth-go/blog-website/assets/140365512/203aafaf-5d9b-4193-870d-728a8c75e58a)
