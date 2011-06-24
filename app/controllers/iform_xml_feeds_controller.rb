class IformXmlFeedsController < ApplicationController
  layout 'iform'
  
  def index
    @iform_xml_feeds = IformXmlFeed.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @iform_xml_feeds }
    end
  end
  
  def create
    require 'json'
    require 'net/http'
  
    resp = Net::HTTP.get_response(URI.parse($iformbuilder_uri))
    iform_xml_feed = IformXmlFeed.new
    iform_xml_feed.body = resp.body
    iform_xml_feed.save    
    
    redirect_to :iform_xml_feeds
  end

  def show
    iform_xml_feed = IformXmlFeed.find(params[:id])
    
    respond_to do |format|
      format.xml  { render :xml => iform_xml_feed.body, :root => 'record' }
      format.json { render :json => Hash.from_xml(iform_xml_feed.body) }
    end
  end
end
