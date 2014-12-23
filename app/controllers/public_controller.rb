class PublicController < ApplicationController
  skip_before_action :require_login

  def seed_db
    Rails.application.load_seed
    redirect_to root_path, notice: 'Successfully re-seeded database'
  end
end
