// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "flowbite"
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import "controllers"
import "./dist/js/jquery/dist/jquery.min.js"
import "./dist/js/materialize.js"
import "./dist/js/app.js"
import "./dist/js/app.init.light-sidebar.js"
import "./dist/js/app-style-switcher.js"
import "./dist/js/custom.js"
import "./dist/js/datatables.js"
import "./dist/js/pages/datatable/datatable-api.init.js"
