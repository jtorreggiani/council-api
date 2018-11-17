require 'json'

JSON.parse(File.open('data/local_authorities.json').read).each do |gss, data|
  Council.find_or_initialize_by(gss: gss).tap do |c|
    c.name = data['name']
    c.url = data['url']
    c.snac = data['snac']
    c.ideal_postcodes_name = data['idealPostcodesName']
    c.save!
  end
end
