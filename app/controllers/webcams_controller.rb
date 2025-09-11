class WebcamsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @service = NationalParkService.new
    @webcams = fetch_webcams
    @states = get_state_options
  end
  
  def search
    @service = NationalParkService.new
    @webcams = fetch_webcams(search_params)
    @states = get_state_options
    render :index
  end
  
  private
  
  def fetch_webcams(params = {})
    result = @service.get_webcams(
      state_code: params[:state_code],
      limit: params[:limit] || 50  # Get more results to filter from
    )
    
    webcams = result['data'] || []
    
    # If a state is selected, filter webcams to only include those from parks in that state
    if params[:state_code].present?
      webcams = webcams.select do |webcam|
        webcam['relatedParks']&.any? do |park|
          park['states']&.include?(params[:state_code])
        end
      end
      
      # Limit to 20 after filtering
      webcams = webcams.first(20)
    end
    
    webcams
  rescue => e
    Rails.logger.error "Failed to fetch webcams: #{e.message}"
    []
  end
  
  def search_params
    params.permit(:state_code, :limit)
  end
  
  def get_state_options
    [
      ['All States', ''],
      ['Alaska', 'AK'], ['Arizona', 'AZ'], ['Arkansas', 'AR'], ['California', 'CA'],
      ['Colorado', 'CO'], ['Connecticut', 'CT'], ['Delaware', 'DE'], ['Florida', 'FL'],
      ['Georgia', 'GA'], ['Hawaii', 'HI'], ['Idaho', 'ID'], ['Illinois', 'IL'],
      ['Indiana', 'IN'], ['Iowa', 'IA'], ['Kansas', 'KS'], ['Kentucky', 'KY'],
      ['Louisiana', 'LA'], ['Maine', 'ME'], ['Maryland', 'MD'], ['Massachusetts', 'MA'],
      ['Michigan', 'MI'], ['Minnesota', 'MN'], ['Mississippi', 'MS'], ['Missouri', 'MO'],
      ['Montana', 'MT'], ['Nebraska', 'NE'], ['Nevada', 'NV'], ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'], ['New Mexico', 'NM'], ['New York', 'NY'], ['North Carolina', 'NC'],
      ['North Dakota', 'ND'], ['Ohio', 'OH'], ['Oklahoma', 'OK'], ['Oregon', 'OR'],
      ['Pennsylvania', 'PA'], ['Rhode Island', 'RI'], ['South Carolina', 'SC'],
      ['South Dakota', 'SD'], ['Tennessee', 'TN'], ['Texas', 'TX'], ['Utah', 'UT'],
      ['Vermont', 'VT'], ['Virginia', 'VA'], ['Washington', 'WA'], ['West Virginia', 'WV'],
      ['Wisconsin', 'WI'], ['Wyoming', 'WY']
    ]
  end
end
