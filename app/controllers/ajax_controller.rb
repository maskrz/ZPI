class AjaxController < ApplicationController
  include CompaniesHelper, IndicesHelper
  def index
  end
  
  def get_indices
    result = []
    indices = Index.all.select([:id, :name]).each{ |item|
     result << { :id => item.id, :name => item.name }
    }
    render json: result
  end    
  
  def get_companies
    indices_list = params[:indices]
    result = []
    companies = Company.joins(:indices).where('indices.id' => indices_list).distinct.select(['companies.id', 'companies.name']).each{ |item|
     result << { :id => item.id, :name => item.name }
    }
    render json: companies
  end
  
  def fetch_indices
    indices = IndicesHelper.fetch_indices
    
    indices.each do |i|
      #check if the record already exists
      Index.find_or_create_by(name: i)
    end
    render json: indices
  end    
  
  def fetch_companies    
    Index.all.each do |index|
      companies = CompaniesHelper.fetch_companies(index.name)
      
      companies.each do |c|
        #check if the record already exists
        company = Company.find_or_create_by(shortcut: c[0], full_id: c[1], name: c[2])  
        index.cindices.create(:company => company)
      end
    end
    render json: ["completed"]
    
  end
end
