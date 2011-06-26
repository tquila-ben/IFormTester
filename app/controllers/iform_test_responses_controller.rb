class IformTestResponsesController < ApplicationController
  layout 'iform'

  require "xmlrpc/client"
  
  def update_sent_to
    session[:sent_to] = params[:sent_to]
    redirect_to :back
  end
  
  def create
    iform_test = IformTest.find(params[:iform_test_id])
    request_via = params[:format] ||= 'rest'
    iform_test.data_records.each{|attr|
      iform_test_response = IformTestResponse.new
      iform_test_response.sent_at = Time.now
      iform_test_response.request_via = request_via
      iform_test_response.iform_test = iform_test
      iform_test_response.header = attr['ID']
      iform_test_response.sent_to, iform_test_response.body = create_response(request_via, attr)
      iform_test_response.save
    }
    redirect_to iform_test_iform_test_responses_path
  end
  
  def index
    @iform_test = IformTest.find(params[:iform_test_id])
    @iform_test_responses = @iform_test.iform_test_responses
    
    respond_to do |format|
      format.html #index.html.haml
    end    
  end
  
  def show
    iform_test_response = IformTestResponse.find(params[:id])
    
    respond_to do |format|
      format.json { render :json => iform_test_response.body }
    end    
  end

  def destroy
    iform_test_response = IformTestResponse.find(params[:id])
    iform_test_response.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def create_response(request_via, attr)
    case request_via
    when 'rest'
      uri = session[:sent_to] || $amortization_rest_uri
      return uri, RestClient.get(uri, {:params => attr})
    when 'xml'
      uri = session[:sent_to] || $amortization_xmlrpc_uri
      attr = attr.reject {|key, value| value.nil?}
      attr = attr.each{|key, value| attr[key] = value.to_f if value.class == BigDecimal}
      xmlrpc_client = XMLRPC::Client.new2( uri )
      resp = xmlrpc_client.call("create_report", attr)
      return uri, resp.to_json
    end
  rescue Exception => e
    return uri, e.message
  end
end
