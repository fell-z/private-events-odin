class EventAttendancesController < ApplicationController
  def create
    EventAttendance.create(attended_event_id: params[:event_id], attendee: current_user)

    respond_to do |format|
      format.js { render inline: "location.reload();" }
    end
  end
end
