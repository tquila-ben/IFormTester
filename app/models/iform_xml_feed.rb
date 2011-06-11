class IformXmlFeed < ActiveRecord::Base
  has_many :next_steps
  
  def get_request_attributes
    aaData = self.body    
    data_hash = Hash.from_xml("<array type='array'>#{aaData}</array>")
    records = data_hash['array'][0]['record']    
    return records.select{|record| !record['ID'].nil? }
  end
end
