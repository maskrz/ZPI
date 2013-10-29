module CompaniesHelper
  require 'open-uri'
  def self.fetch_companies(index_name)
    response =  open(URI.parse('http://www.gpw.pl/ajaxindex.php?action=GPWCompanySearch&start=listForIndex&listTemplateName=GPWCompanySearch/ajaxList_PL&index='+index_name)).read
    
    pattern = />.*([A-Z]{3}).*\s*?.*\/(.*)\/">(.*)<\/a/
    companies_temp = response.scan(pattern).to_a
  end
end
