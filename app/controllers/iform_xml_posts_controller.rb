class IformXmlPostsController < ApplicationController
  layout 'iform'
  require "xmlrpc/marshal" 
  
  skip_before_filter :verify_authenticity_token, :only => :create
  
  def index
    @iform_xml_posts = IformXmlPost.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @iform_xml_posts }
    end
  end
  
  def create
    iform_xml_post = IformXmlPost.new
    iform_xml_post.body = params.to_json
    iform_xml_post.save    
    render :json => params
  end

  def show
    iform_xml_post = IformXmlPost.find(params[:id])
    
    respond_to do |format|
      format.xml  { render :xml => ActiveSupport::JSON.decode(iform_xml_post.body), :root => 'record' }
      format.json { render :json => iform_xml_post.body }
    end
  end

  # report request submit via XMLRPC
  def create_xmlrpc
   xml = request.body.read
 
   if(xml.empty?)
     error = 400
     return
   end
 
   # Parse xml
   method, arguments = XMLRPC::Marshal.load_call(xml)
   puts "....method:#{method}"
   puts "....arguments:#{arguments.inspect}"
   arg = arguments[0]
   response = create_report(arg)
    
   redirect_to retrieve_response_url(iform_xml_feed, :format => 'xml') 
  end
  
  def create_report(args)
    puts "...args:#{args.inspect}"
    handler = PricingXmlrpcHandler.new
    return handler.get_price_model(args)
  end  
end
