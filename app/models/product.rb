class Product < ApplicationRecord

  validates :name, :price, presence: true
  validates :price, numericality: {greater_than: 0, less_than: 10000000}
  
  def to_s
    name
  end

  monetize :price, as: :price_cents

  # transform shopping cart products into an array of line items
  def to_builder
    Jbuilder.new do |product|
      product.price stripe_price_id
      product.quantity 1
    end
  end

  # create stripe product and assign to this product
  after_create do
    product = Stripe::Product.create(name: name)
    price = Stripe::Price.create(product: product, unit_amount: self.price, currency: self.currency)
    update(stripe_product_id: product.id, stripe_price_id: price.id)
  end

  # stripe keeps products and prices separately. 
  # updating local prices would require to update or create stripe prices.
  # this is all additional complexity.
  # better just create new products.

  # after_update :create_and_assign_new_stripe_price, if: :saved_change_to_price?
  # after_update :create_and_assign_new_stripe_price, if: :saved_change_to_currency?

  # def create_and_assign_new_stripe_price
  #   price = Stripe::Price.create(product: self.stripe_product_id, unit_amount: self.price, currency: self.currency)
  #   update(stripe_price_id: price.id)
  # end

end
