class IformXmlPost < ActiveRecord::Base
  has_one :iform_test
  before_create '(self.iform_test = IformTest.new).body = data_records'
  
  def header
    iform_test.header
  end
  
  def data_records
    body_hash = ActiveSupport::JSON.decode(body)
    data_hash = Hash.from_xml("<array type='array'>#{body_hash['key']}</array>")
    return [data_hash['array'][0]['record']['record']].to_json
  end
end
