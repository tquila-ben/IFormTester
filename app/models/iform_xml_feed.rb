class IformXmlFeed < ActiveRecord::Base
  has_many :next_steps
  
  def get_request_attributes
    aaData = self.body    
    data_hash = Hash.from_xml("<array type='array'>#{aaData}</array>")
    records = data_hash['array'][0]['record']    
    records = records.select{|record| !record['ID'].nil? }
    records.each{|record_data|
      record_data['rate'] = 0.03
      record_data['term'] = 360
      record_data['principal_forbearance'] = 0
      record_data['unpaid_balance'] = 200000
      record_data['month_i'] = 7
    }
    records
  end
end
