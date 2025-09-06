class Trip < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :date, presence: true
  validates :notes, length: { maximum: 1000 }

  scope :recent, -> { order(date: :desc) }
  scope :upcoming, -> { where('date >= ?', Date.current) }
  scope :past, -> { where('date < ?', Date.current) }

  def formatted_date
    date&.strftime('%B %d, %Y')
  end

  def status
    return 'upcoming' if date >= Date.current
    'completed'
  end

  def status_color
    status == 'upcoming' ? 'text-blue-600' : 'text-green-600'
  end
end
