class Festival::HeaderColor < ActiveRecord::Base
  belongs_to :festival
  validates_uniqueness_of :festival_id
  validates_presence_of :red, :green, :blue

  def as_json(options={})
    super(except: [:id, :festival_id])
  end
end
