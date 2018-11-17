namespace :councils do
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
end
