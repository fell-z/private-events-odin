class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[ new create ]
  before_action :set_event, except: %i[ index new create ]

  def index
    @past_events = Event.past
    @upcoming_events = Event.upcoming
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      flash[:success] = "Nice! Your event was created."
      redirect_to root_path
    else
      flash.now[:error] = "Your event couldn't be created."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @event.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.expect(event: [ :name, :location, :date, :status ])
  end
end
