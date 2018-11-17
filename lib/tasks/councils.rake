require 'uri'
require 'net/http'
require 'csv'

namespace :councils do

  task csv: :environment do
    CSV.foreach("data/Interim_Local_Authority_Districts_April_2018_Names_and_Codes_in_the_United_Kingdom.csv", headers: false) do |row|
      if council = Council.find_by(gss: row[0])
        council.update_attributes(
          lad18nm: row[1],
          fid: row[3]
        )
      else
        p row[0] + " does not exist"
      end
    end
  end

  task ideal: :environment do
    ob = {}
    councils = Council.where(ideal_postcodes_name: nil).map do |c|
      ob[c.gss] = c.name
      # {
      #   id: c.gss,
      #   name: c.name,
      #   url: c.url,
      #   snac: c.snac
      # }
    end
    File.open('councils.json', 'w') { |file| file.write(ob.to_json) }
  end

  task ping: :environment do

    Parallel.each(Council.all) do |council|
      ActiveRecord::Base.connection_pool.with_connection do

        is_up = false

        # puts council.name, council.url

        begin
          ping = Net::HTTP.get_response(URI.parse(council.url))
          if ping and ["2", "3"].include?(ping.code[0])
            is_up = true
          end
        rescue
          # p "DATA ERROR"
        end

        Ping.create!(
          council: council,
          is_up: is_up
        )

        council.update_attribute(:is_online, is_up)

      end
      Council.connection.reconnect!

    end

  end
end
