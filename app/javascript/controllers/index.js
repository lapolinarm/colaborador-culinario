// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

//stimulus import dashboard
import DashboardController from "./dashboard_controller"
application.register("dashboard", DashboardController)

import HomeController from "./home_controller"
application.register("home", HomeController)
