require 'csv'
namespace :import do
  desc "Importing all of the guests from a csv file"
  task :guests => :environment do
    csv_text = File.read(File.join(Rails.root, '/db/guest_lists.csv'))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      guest_hash = row.to_hash
      puts "Importing #{guest_hash["display_name"]}"
      guest = Guest.where(id: guest_hash["id"])
      if guest.count == 1
        puts "updating existing value"
        guest.first.update_attributes(guest_hash)
      else
        if guest_hash.has_key?("display_name")
          puts "creating new guest"
          Guest.create!(row.to_hash)
        else
          puts "** blank row **"
          puts guest_hash
        end
      end
    end
  end
end
