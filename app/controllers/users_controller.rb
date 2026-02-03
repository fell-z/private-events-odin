class UsersController < ApplicationController
  def show
    @created_events = User.find(params[:id]).created_events
  end
end
