class EventsController < ApplicationController
  def index
    if params.key? :after
      after_date = DateTime.strptime(params[:after], '%s')
      @events = Event.where('datetime(created_at) > :date', date: after_date.to_s(:db))
    else
      @events = Event.all
    end

    puts @events.length

    render json: @events, root: nil, scope: get_device_scope
  end
end