class Neighborhood < ActiveRecord::Base
  validates_uniqueness_of :name

  searchable(auto_index: true) do
    text :name
  end

  def self.autocomplete_search(query, coordinates=nil, options={})
    options = {page: 1, per_page: 30}.merge(options)
    ids = self.solr_search_ids {
      keywords(query) { minimum_match(query.strip.blank? ? 0 : 1) }
      paginate(page: options[:page], per_page: options[:per_page])
    }
    connection.select_values(
      self.select('DISTINCT(name)').where(id: ids).to_sql
    ).map(&:strip)
  end
end
