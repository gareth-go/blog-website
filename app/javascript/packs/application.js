// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.


import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"


Rails.start()
Turbolinks.start()
ActiveStorage.start()

// require.context('@../images', true);
// import "../images/home-icon"
import "bootstrap"
import "../stylesheets/application.scss"
import "../stylesheets/create_post.scss"
import "../stylesheets/home.scss"
import "../stylesheets/post.scss"
import "@fortawesome/fontawesome-free/js/all";
import "@fortawesome/fontawesome-free/css/all";
import "select2" 
import "./create_post"
import "./edit_post"
import "./home"
require("trix")
require("@rails/actiontext")
const images = require.context('../images', true)

