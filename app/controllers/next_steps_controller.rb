class NextStepsController < ApplicationController

  require "xmlrpc/client"
    
  def show_request
    @iform_xml_feed = IformXmlFeed.find(params[:id])
    attrs = @iform_xml_feed.get_request_attributes
    
    respond_to do |format|
      format.xml  { render :xml => attrs }
      format.json  { render :json => attrs }
    end
  end
  
  def retrieve_response
    iform_xml_feed = IformXmlFeed.find(params[:id])
    request_via = params[:format] ||= 'http post'
    attrs = iform_xml_feed.get_request_attributes
    attrs.each{|attr|
    puts "....attr['beginning_interest_rate']:#{attr['beginning_interest_rate']}"
      next_step = NextStep.new
      next_step.sent_at = Time.now
      next_step.request_via = request_via
      next_step.iform_xml_feed = iform_xml_feed
      create_response(request_via, attr, next_step)
      next_step.save
    }
    redirect_to show_next_steps_path
  end
  
  def show_response
    next_step = NextStep.find(params[:id])

    render :json => next_step.body
  end
  
  private
  
  def create_response(request_via, attr, next_step)
    case request_via
    when 'json'
      resp_body = RestClient.post $amortization_json_uri, {:data => attr}, {:content_type => :json, :accept => :html}
    when 'xml'
      attr = attr.reject {|key, value| value.nil?}
      attr = attr.each{|key, value| attr[key] = value.to_f if value.class == BigDecimal}
      xmlrpc_client = XMLRPC::Client.new2( $amortization_xmlrpc_uri )
      resp = xmlrpc_client.call("create_report", attr)
      resp_body = resp.to_json
    else
      resp = Net::HTTP.post_form(URI.parse($amortization_http_post_uri), attr)
      resp_head = resp.to_hash
      resp_body = resp.body
    end
    next_step.header = resp_head
    next_step.body = resp_body
    next_step.profile_code = attr['ID']
  end
end
