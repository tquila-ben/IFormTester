class IformXmlFeed < ActiveRecord::Base
  has_one :iform_test
  before_create '(self.iform_test = IformTest.new).body = data_records'
  
  def header
    iform_test.header
  end
  
  def record_count
    iform_test.record_count
  end
  
  def data_records
    data_hash = Hash.from_xml("<array type='array'>#{self.body}</array>")
    return data_hash['array'][0]['record'].to_json
  end
end
