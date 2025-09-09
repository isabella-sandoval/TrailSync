class HomeController < ApplicationController
  def index
    @nps_service = NationalParkService.new
    
    # Fetch recent events from National Parks (limit to 6 for homepage display)
    events_response = @nps_service.get_events(limit: 6)
    @events = events_response['data'] || []
    
    # Handle any API errors gracefully
    @events_error = events_response['error'] if events_response['error']
  rescue => e
    Rails.logger.error "Error fetching events for homepage: #{e.message}"
    @events = []
    @events_error = "Unable to load events at this time"
  end
end
