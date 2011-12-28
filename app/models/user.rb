class User < ActiveRecord::Base
  include Roles
  serialize :roles, Array

  has_many :pictures
  has_many :restaurant_bookmarks, class_name: 'Restaurant::Bookmark'
  has_many :bookmarked_restaurants, through: :restaurant_bookmarks, source: :restaurant
  has_many :menu_item_bookmarks, class_name: 'Restaurant::Menu::Item::Bookmark'
  has_many :bookmarked_menu_items, through: :menu_item_bookmarks, source: :restaurant_menu_item
  has_many :restaurant_ratings, class_name: 'Restaurant::Rating'
  has_many :menu_item_ratings, class_name: 'Restaurant::Menu::Item::Rating'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :token_authenticatable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :username, :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :postal_code, :country, :gender, :birthday, :authentication_token

  # Virtual attribute for authenticating by either username or email
  attr_accessor :login

  COUNTRIES = ['United States', 'Canada'].freeze

  validates_uniqueness_of :username, :email, :case_sensitive => false
  validates_inclusion_of :gender, :in => %w{m f}, :allow_blank => true
  validates_inclusion_of :country, :in => COUNTRIES, :allow_blank => true
  before_save :ensure_authentication_token

  def ratings_count
    [restaurant_ratings, menu_item_ratings].map(&:count).inject {|s, c| s.to_i + c }
  end

  def pictures_gallery
    pictures
      .where('pictures.restaurant_id IS NOT NULL')
      .includes(:user, :restaurant, :menu_item)
      .group_by {|obj| obj.created_at.to_date }
      .map {|k,v| {date: k, pictures_by_restaurant: v.group_by(&:restaurant_id).map {|key, val| {restaurant_id: key, restaurant_name: val.first.restaurant.name, pictures: val}}}}
  end

  def self.countries
    COUNTRIES.dup
  end

  def update_without_password(params={})
    current_password = if params[:current_password].present?
      params.delete(:current_password)
    end

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = if (has_no_password? or valid_password?(current_password) or current_password.blank?)
      update_attributes(params) 
    else
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      self.attributes = params
      false
    end

    clean_up_passwords
    result
  end

  def has_no_password?
    self.encrypted_password.blank?
  end

  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where('lower(username) = :value OR lower(email) = :value', value: login.downcase).first
  end

  def self.send_reset_password_instructions(attributes={})
     recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
     recoverable.send_reset_password_instructions if recoverable.persisted?
     recoverable
   end 

   def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
     (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

     attributes = attributes.slice(*required_attributes)
     attributes.delete_if { |key, value| value.blank? }

     if attributes.size == required_attributes.size
       if attributes.has_key?(:login)
          login = attributes.delete(:login)
          record = find_record(login)
       else  
         record = where(attributes).first
       end  
     end  

     unless record
       record = new

       required_attributes.each do |key|
         value = attributes[key]
         record.send("#{key}=", value)
         record.errors.add(key, value.present? ? error : :blank)
       end  
     end  
     record
   end

  def self.find_record(login)
    where('username = :value OR email = :value', value: login).first
  end
end
