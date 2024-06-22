# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.js"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "popper", to: 'popper.js', preload: true
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
# AdminLTE
pin "admin-lte", to: "https://ga.jspm.io/npm:admin-lte@3.1.0/dist/js/adminlte.min.js", preload: true
pin "flash_messages", to: "flash_messages.js"
pin "players", to: "players.js"
pin "games", to: "games.js"
pin "splash", to: "splash.js"
pin "union_teams", to: "union_teams.js"
pin "wp_articles", to: "wp_articles.js"
