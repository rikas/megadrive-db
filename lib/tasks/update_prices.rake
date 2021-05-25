require 'price_scrapper'

desc 'Fetch prices from the web and update games with up to date prices'
task update_prices: :environment do
  PriceScrapper.read_prices do |price|
    game = Game.find_by(name: price.game)

    if game.present?
      game.update(estimated_price: price.value)
    else
      puts "Could not find game #{price.game}!!!"
    end
  end
end
