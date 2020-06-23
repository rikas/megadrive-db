file = File.open(File.join(Rails.root, 'db', 'game_list.json'))
data = JSON.load(file, symbolize_names: true)

data.each do |game_name|
  Game.where(name: game_name).first_or_create
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?