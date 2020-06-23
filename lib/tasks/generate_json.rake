namespace :generate do
  desc 'Generate the games json to be used in the Vue app'
  task json: :environment do
    puts "Generating JSON file..."

    games = Game.sorted

    file = File.open(File.join(Rails.root, 'app', 'javascript', 'games.json'), 'w')
    file.write(games.to_json(methods: :status))
    file.close

    puts 'Done'
  end
end
