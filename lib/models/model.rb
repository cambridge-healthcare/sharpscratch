require 'ohm'

Ohm.connect(:url => ENV['REDIS_URI'])

module Model
  def attributes
    super.merge(:id => id)
  end

  NotFoundError = Class.new(StandardError)
end
