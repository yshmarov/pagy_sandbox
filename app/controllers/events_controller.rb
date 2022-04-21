class EventsController < ApplicationController
  def index
    # @events = Event.order(start: :desc)
    # @pagy, @events = pagy(Event.order(created_at: :desc), items: 5)
    collection = Event.order(start: :asc)
    @calendar, @pagy, @events = pagy_calendar(collection, year: { size: [1, 1, 1, 1] },
                                                            month: { size: [0, 12, 12, 0],
                                                            # week: {},
                                                            format: '%b' },
                                                            day: { size: [0, 31, 31, 0], format: '%d' },
                                                            pagy: { items: 2 },
                                                            active: !params[:skip])
  end

  private

  def pagy_calendar_period(collection)
    # return [DateTime.now.getlocal, DateTime.now.getlocal]
    # return [DateTime.now.getlocal, DateTime.now.getlocal] if collection.empty?
    collection.map(&:start).minmax.map(&:getlocal)
  end

  def pagy_calendar_filter(collection, from, to)
    collection.where(start: from...to)
    # collection.where('start BETWEEN ? AND ?', from.utc, to.utc)
  end
end
