class ApplicationController < Sinatra::Base
  # Add this line to set the Content-Type header for all responses:
  set :default_content_type, 'application/json'

  get '/bakeries' do
    # Get all the bakeries from the db
    bakeries = Bakery.all
    # Send them back as a JSON array
    bakeries.to_json
  end

  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json(include: :baked_goods)
  end
  
  get '/baked_goods/by_price' do
    goods = BakedGood.order(price: :desc)
    goods.to_json
  end

  get '/baked_goods/most_expensive' do
    good = BakedGood.order(price: :desc).limit(1)
    # This should work but it's not passing last test
    good.to_json(only: [:name, :price])
  end
end
