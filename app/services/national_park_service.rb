class NationalParkService
  include HTTParty
  base_uri 'https://developer.nps.gov/api/v1'
  
  def initialize
    # Option 1: Rails Credentials (Recommended)
    @api_key = Rails.application.credentials.nps[:api_key] if Rails.application.credentials.nps
    
    # Option 2: Environment Variables (Fallback)
    @api_key ||= ENV['NPS_API_KEY']
    
    raise "NPS API key not configured. Add to Rails credentials or ENV['NPS_API_KEY']" if @api_key.blank?
  end
  
  # Get events for parks
  def get_events(park_code: nil, state_code: nil, limit: 10)
    options = {
      query: {
        api_key: @api_key,
        parkCode: park_code,
        stateCode: state_code,
        limit: limit
      }.compact
    }
    
    response = self.class.get('/events', options)
    handle_response(response)
  end
  
  private
  
  def handle_response(response)
    if response.success?
      response.parsed_response
    else
      Rails.logger.error "NPS API Error: #{response.code} - #{response.message}"
      { 'data' => [], 'error' => "API request failed: #{response.message}" }
    end
  rescue => e
    Rails.logger.error "NPS API Exception: #{e.message}"
    { 'data' => [], 'error' => "Service unavailable: #{e.message}" }
  end
end
