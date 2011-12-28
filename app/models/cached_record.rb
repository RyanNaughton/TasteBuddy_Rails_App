class CachedRecord < ActiveRecord::Base
  validates_presence_of :json, :festival_id
end
