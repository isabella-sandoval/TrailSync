class ThingsToDoController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @service = NationalParkService.new
    @activities = fetch_featured_activities
  end
  
  private
  
  def fetch_featured_activities
    # Get activities from popular national parks to ensure good content
    popular_parks = ['yell', 'grca', 'yose', 'zion', 'arch', 'brca', 'glac', 'romo', 'grsm', 'acad']
    all_activities = []
    
    # Fetch activities from multiple popular parks
    popular_parks.first(5).each do |park_code|
      result = @service.get_things_to_do(park_code)
      if result['data']&.any?
        all_activities.concat(result['data'].first(4)) # Get top 4 from each park
      end
    end
    
    # If we don't have enough activities, get some general ones
    if all_activities.length < 15
      general_result = @service.get_things_to_do(limit: 30)
      if general_result['data']&.any?
        all_activities.concat(general_result['data'])
      end
    end
    
    # Remove duplicates and limit to 24 activities
    all_activities.uniq { |activity| activity['id'] }.first(24)
  rescue => e
    Rails.logger.error "Failed to fetch featured activities: #{e.message}"
    []
  end
end
