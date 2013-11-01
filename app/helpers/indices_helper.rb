module IndicesHelper
  require 'open-uri'
  def self.fetch_indices
    response =  open(URI.parse('http://www.gpw.pl/indeksy_gieldowe')).read    
    pattern = /left"><a href=".{,83}">([A-Za-z0-9\-\.]{,10})/
    response.scan(pattern).to_a.flatten(1)
  end
end
