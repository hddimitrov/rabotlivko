require 'csv'

namespace :cities do
  desc 'Update cities coords'
  task :lat_lon => :environment do
    puts 'Updating coords'

    CSV.foreach('db/data/cities_lat_lon.csv', headers: :first_row) do |row|
      puts row['name']
      city = City.find_by_name(row['name'])
      if city.present?
        city.lat = row['lat']
        city.lon = row['lon']
        city.save
      end
    end
  end
end
