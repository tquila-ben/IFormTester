class IformXmlFeedsController < ApplicationController
  layout 'iform'
  
  def update_feed_from
    session[:feed_from] = params[:feed_from]
    redirect_to :back
  end
  
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
  
    uri = session[:feed_from] || $iformbuilder_uri
    begin
      resp = Net::HTTP.get_response(URI.parse(uri))
      iform_xml_feed = IformXmlFeed.new
      iform_xml_feed.body = resp.body
      if iform_xml_feed.save
        flash[:notice] = 'XML Feed retrieved successfully.'
      end
    rescue Exception => e
      flash[:error] = e.message
    end
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
