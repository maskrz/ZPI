class AjaxController < ApplicationController
  include CompaniesHelper, IndicesHelper, MessagesHelper
  def index
  end
  
  def get_messages
    result = get_users_conversation(current_user.id, params[:interlocutor_id], params[:batch_start].to_i)[:messages].reverse.to_json
    render json: result
  end
  
  def get_indices
    result = []
    indices = Index.all.select([:id, :name]).each{ |item|
     result << { :id => item.id, :name => item.name }
    }
    render json: result
  end    
  
  def get_companies(filter = [])
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
  
  def order_analysis
    columns = TempAnalisy.attribute_names - ['created_at', 'updated_at']
    temp_analysis = TempAnalisy.where(:company_id => params[:companies], :period => params[:periods]).select(columns)

    response = [].tap do |result|
      temp_analysis.each do |ta|
        attrs_to_copy = ta.attributes
        attrs_to_copy.delete("id")
        result.push(attrs_to_copy)
        analysis = Analisy.find_or_create_by(attrs_to_copy) #rmove id from attrs!
        result.push(analysis)
        user_analysis = current_user.user_analyses.find_or_create_by(:analisy => analysis)
        result.push(user_analysis)
      end
    end
    render json: response
  end
  
  def get_user_analysis_history
    page = params[:page_no].to_i
    filters = params[:filters]
    @analysis = current_user.get_analysies_history(page, filters)
    #render json: @analysis
    render 'home/wall'
  end
  
  def get_user_company_analysis_for_day
    company_id = params[:company_id]
    date = params[:date]
    response = current_user.get_user_company_analysis_for_day(company_id, date)
    render :partial => 'partials/analysis_item_body', :locals => { :object => response }
  end
end
