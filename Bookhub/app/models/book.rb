class Book
  include Mongoid::Document
  field :title, type: String
  field :author, type: String
  field :days_to_borrow, type: Integer
  field :reserved, type: Integer
  belongs_to :owner, :class_name => 'User', :inverse_of => :books_owned
  belongs_to :borrower, :class_name => 'User', :inverse_of => :books_borrowed
end
