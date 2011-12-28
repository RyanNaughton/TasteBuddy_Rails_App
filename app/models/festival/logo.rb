class Festival::Logo < ActiveRecord::Base
  belongs_to :festival
  validates_uniqueness_of :festival_id
  validates_presence_of :standard_resolution, :low_resolution

  def as_json(options={})
    super(except: [:id, :festival_id])
  end
end
