require 'csv'

namespace :cities do
  desc 'Update cities coords'
  task :lat_lon => :environment do
    puts 'Updating coords'

    CSV.foreach('db/data/NM_2011.csv', headers: :first_row) do |row|
      city = City.find_by_name(row['Name_bg'])
      if city.present?
        city.lat = row['Latitude']
        city.lon = row['Longitude']
        city.save
      end
    end
  end
end
