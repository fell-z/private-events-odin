class EventAttendancesController < ApplicationController
  def create
    Event.find(params[:event_id]).attendees << User.find(attendee_params)

    respond_to do |format|
      format.js { render inline: "location.reload();" }
    end
  end

  def destroy
    @event_attendance = EventAttendance.find_by(attended_event_id: params[:event_id], attendee_id: params[:attendee_id])

    @event_attendance.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def attendee_params
    # Weird behavior that, when using a select multiple html tag,
    # includes a empty string even if there is a selected value.
    params.expect(attendee_ids: []).reject(&:blank?)
  end
end
