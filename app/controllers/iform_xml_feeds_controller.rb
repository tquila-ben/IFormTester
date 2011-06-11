class IformXmlFeedsController < ApplicationController
  layout 'iform'
  
  def index
    @iform_xml_feeds = IformXmlFeed.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @iform_xml_feeds }
    end
  end
  
  def show
    @iform_xml_feed = IformXmlFeed.find(params[:id])
    
    respond_to do |format|
      format.html { render 'show', :layout => false }
      format.json { show_data_table }
      format.xml  { render :xml => @iform_xml_feed.body }
    end
  end
  
  def show_data_table
    iform_xml_feed = IformXmlFeed.find(params[:id])
    aaData = iform_xml_feed.body
    
    data_hash = Hash.from_xml("<array type='array'>#{aaData}</array>")
    records = data_hash['array'][0]['record']
    aaData = Array.new
    records.each{|record_data|
       created_location = record_data['CREATED_LOCATION'].split(':').collect! {|n| n}       
       record_row = Array.new
       record_row << record_data['beginning_interest_rate']
       record_row << record_data['original_term']
       record_row << record_data['principal_and_interest_lien1']
       record_row << created_location[0]
       record_row << created_location[1]
       aaData << record_row
    }
    data_table = { "aaData" => aaData }

    render :json => data_table
  end
  
  def retrieve_iform
    require 'json'
    require 'net/http'
  
    resp = Net::HTTP.get_response(URI.parse($iformbuilder_uri))
    aaData = resp.body
    data_hash = Hash.from_xml("<array type='array'>#{aaData}</array>")
    records = data_hash['array'][0]['record']
    record_summary = records.collect{|record_data| record_data['ID']}

    iform_xml_feed = IformXmlFeed.new
    iform_xml_feed.body = aaData
    iform_xml_feed.header = record_summary.join(', ')
    iform_xml_feed.record_count = records.size
    iform_xml_feed.save    
    
    redirect_to :iform_xml_feeds
  end
  
  def show_next_steps
    @iform_xml_feed = IformXmlFeed.find(params[:id])
    @next_steps = @iform_xml_feed.next_steps
    
    respond_to do |format|
      format.html #show_next_steps.html.haml
    end
  end
end
