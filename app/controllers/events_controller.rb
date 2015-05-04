class EventsController < ApplicationController
  def index
    if params.key? :after
      after_date = DateTime.strptime((params[:after].to_i + 1).to_s, '%s')
      # @events = Event.where('created_at > :date OR updated_at > :date', date: after_date)
      @events = Event.after(after_date)
    else
      @events = Event.all
    end

    puts @events.length

    render json: @events, root: nil, scope: get_device_scope
  end
end
