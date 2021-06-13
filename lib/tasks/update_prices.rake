require 'price_scrapper'

IGNORE_LIST = [
  'Ultracore',
  'Daze Before Christmas',
  'Sega Mega Drive Console',
  'Fatal Fury 2'
]

def cleanup(name)
  clean = name.gsub(/The /, '')
end

def escape(name)
  name.gsub("'", "''").strip
end

desc 'Fetch prices from the web and update games with up to date prices'
task update_prices: :environment do
  errors = 0

  PriceScrapper.read_prices do |price|
    next if IGNORE_LIST.include?(price.game)

    game = Game.find_by('name ILIKE ?', "%#{price.game}%")
    game ||= Game.find_by('name ILIKE ?', "%#{escape(cleanup(price.game))}%")
    game ||= Game.find_by("'#{escape(price.game)}' ILIKE ANY(alternative_names)")

    if game.present?
      game.update(estimated_price: price.value)
    else
      errors += 1
      puts "Could not find game #{price.game}"
    end
  end

  puts "Total errors: #{errors}"
end
