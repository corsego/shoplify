# "Buy now" button with Ruby on Rails and Stripe Checkout API

* [Live demo](https://shoplify.herokuapp.com/)
* [Github source](https://github.com/yshmarov/shoplify)
* [Stripe Dashboard](https://dashboard.stripe.com/)
* [Stripe test credit cards](https://stripe.com/docs/testing)
* [Stripe Checkout Migration guide](https://stripe.com/docs/payments/checkout/migration)

Button to buy a product
![A screenshot of the app.](./shoplify-preview.png)

Redirects to Stripe Checkout page
![stripe checkout preview.](./stripe-checkout-preview.png)

****

generate scaffold:
```
rails g scaffold product name price:integer description:text --no-helper --no-assets --no-controller-specs --no-view-specs --no-test-framework --no-jbuilder 
```

****

[Guide: editing credentials](https://blog.corsego.com/ruby-on-rails-6-credentials-tldr)
```
EDITOR=vim rails credentials:edit
```

****

credentials.yml structure:
```
stripe:
  publishable: YOUR_CODE
  secret: YOUR_CODE
  webhook: YOUR_CODE
```

****

# Next step 

Connect products from database with Stripe Products
```
stripe_product = Stripe::Product.create(name: "iphone 14")
stripe_price = Stripe::Price.create(currency: "usd", product: stripe_product, unit_amount: 77700)
product = Product.create(name: stripe_product.name, price: stripe_price.unit_amount, stripe_product_id: stripe_product.id)
```
