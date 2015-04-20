class EventsController < ApplicationController
  def index
    @events = Event.all

    render json: @events, root: nil, scope: get_device_scope
  end
end