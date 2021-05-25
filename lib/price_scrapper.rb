require 'rest-client'

class PriceScrapper
  URL = 'https://www.pricecharting.com/console/pal-sega-mega-drive?cursor='

  def read_page(page)
    body = RestClient.get(URL + page.to_s).body
    doc = Nokogiri::HTML.parse(body)

    games = doc.css('tr[data-product]')
    prices = []

    games.each do |game|
      price = game.css('.cib_price').last.text.strip
      price.gsub!('$', '')

      price = (price.to_f * 100).to_i

      prices << OpenStruct.new(
        value: price,
        game: game.css('td.title').text.strip
      )
    end

    prices
  end

  def self.read_prices(&block)
    new.read_prices(&block)
  end

  def read_prices(&block)
    0.upto(12) do |page|
      puts "Reading page #{page}..."

      read_page(page * 50).each do |price|
        yield price
      end
    end
  end
end
