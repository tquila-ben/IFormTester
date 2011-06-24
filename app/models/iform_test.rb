class IformTest < ActiveRecord::Base
  belongs_to :iform_xml_feed
  belongs_to :iform_xml_post
  has_many :iform_test_responses
  
  def data_records
    ActiveSupport::JSON.decode(body)
  end
  
  def header
    data_records.collect{|record_data| record_data['ID']}.join(', ')
  end
  
  def record_count
    data_records.size
  end
end
