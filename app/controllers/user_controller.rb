class UserController < ApplicationController
  skip_after_action :verify_policy_scoped, only: :show

  def show
    authorize @user
  end
end
