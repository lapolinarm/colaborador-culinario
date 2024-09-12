class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @jobs = Job.includes(:restaurant).all
  end

  def about
  end

  def dashboard
  end
end
