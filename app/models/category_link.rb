class CategoryLink < ActiveRecord::Base
  belongs_to :category
  belongs_to :parent, class_name: :Category
end