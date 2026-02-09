class EventAttendancesController < ApplicationController
  def create
    Event.find(params[:event_id]).attendees << User.find(attendee_params)

    respond_to do |format|
      format.js { render inline: "location.reload();" }
    end
  end

  private

  def attendee_params
    # Weird behavior that, when using a select multiple html tag,
    # includes a empty string even if there is a selected value.
    params.expect(attendee_ids: []).reject(&:blank?)
  end
end
