class Picture < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant
  belongs_to :menu_item, class_name: 'Restaurant::Menu::Item'

  validates_presence_of :user

  STYLES = {
    :original    => ['1920x1680>'],
    :'640px'     => ['640x640#',   :jpg],
    :'300px'     => ['300x300#',   :jpg],
    :'160px'     => ['160x160#',   :jpg],
    :'80px'      => ['80x80#',     :jpg],
  }

  has_attached_file :attachment,
    :storage        => :s3,
    :s3_credentials => TasteBuddy::S3_CREDENTIALS,
    :path           => ':attachment/:id/:style.:extension',
    :bucket => "taste_buddy-#{Rails.env}",
    :styles => STYLES

  EXPORT_STYLES = [:'640px', :'300px', :'160px', :'80px'].freeze

  def export_styles
    EXPORT_STYLES.dup
  end
end
