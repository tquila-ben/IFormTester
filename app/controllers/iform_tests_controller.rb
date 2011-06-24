class IformTestsController < ApplicationController

  def show
    @iform_test = IformTest.find(params[:id])
    
    respond_to do |format|
      format.html { render 'show', :layout => false }
      format.xml  { render :xml => @iform_test.data_records, :root => 'record' }
      format.json { show_data_table }
    end
  end
  
  def show_data_table
    iform_test = IformTest.find(params[:id])
    
    aaData = Array.new
    iform_test.data_records.each {|data_record|
      created_location = data_record['CREATED_LOCATION'].split(':').collect! {|n| n}
      record_row = Array.new
      record_row << data_record['beginning_interest_rate']
      record_row << data_record['original_term']
      record_row << data_record['principal_and_interest_lien1']
      record_row << created_location[0]
      record_row << created_location[1]
      aaData << record_row
    }    
    data_table = { "aaData" => aaData }

    render :json => data_table
  end
end
