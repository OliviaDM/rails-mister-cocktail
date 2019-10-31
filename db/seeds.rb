# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'

# ing = JSON.parse(open('https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list').read)

# ing["drinks"].each do |ingredient|
#   name = ingredient["strIngredient1"]
#   new_ing = Ingredient.new(name: name)
#   new_ing.save
# end

url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'

20.times do
  info = JSON.parse(open(url).read)["drinks"][0]
  cocktail_name = info["strDrink"]
  cocktail_image = info["strDrinkThumb"]
  new_cocktail = Cocktail.new(name: cocktail_name, image_url: cocktail_image)
  if new_cocktail.save

    (1..15).to_a.each do |i|
      ing_name = info["strIngredient#{i}"]
      unless ing_name.nil?
        ing = Ingredient.find_by(name: ing_name)
        unless ing.nil? || new_cocktail.nil?
          descr = info["strMeasure#{i}"]
          new_dose = Dose.new(cocktail_id: new_cocktail.id, ingredient_id: ing.id, description: descr)
          new_dose.save
        end
      end
    end

  end
end
