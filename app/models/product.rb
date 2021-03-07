class Product < ApplicationRecord

  validates :name, :price, presence: true
  
  def to_s
    name
  end

end
