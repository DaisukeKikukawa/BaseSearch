//= require popper
//= require bootstrap
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import jquery from "jquery"
window.$ = jquery
// Active Text
import "trix"
import "@rails/actiontext"
// AdminLTE
import "admin-lte"
// Custom
import "flash_messages"
// views
import "players"
import "games"
import "union_teams"
import "wp_articles"
