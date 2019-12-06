class User
  include Mongoid::Document
  field :email, type: String
  field :family_name, type: String
  field :given_name, type: String
  field :phone_number, type: String
  field :google_id, type: String
  field :name, type: String
  field :photo_url, type: String
  has_many :books_owned, :class_name => 'Book', :inverse_of => :owner
  has_many :books_borrowed, :class_name => 'Book', :inverse_of => :borrower
end
