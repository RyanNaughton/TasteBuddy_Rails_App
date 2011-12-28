class Festival < ActiveRecord::Base
  has_one :header_color, class_name: 'Festival::HeaderColor'
  has_one :logo, class_name: 'Festival::Logo'

  validates_presence_of :name

  def distance_to(coordinates)
    Haversine
      .distance(latitude.to_f, longitude.to_f, *coordinates.map(&:to_f))[:miles]
      .number
      .round(2)
  end

  def self.coordinates_valid?(coordinates)
    coordinates.to_a.slice(0,2).map(&:to_f).all?(&:nonzero?)
  end

  def as_json(options={})
    super(include: [:header_color, :logo], except: [:created_at, :updated_at])
  end
end
