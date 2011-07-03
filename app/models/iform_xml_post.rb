class IformXmlPost < ActiveRecord::Base
  has_one :iform_test
  before_create '(self.iform_test = IformTest.new).body = data_records'
  
  def header
    iform_test.header
  end
  
  def data_records
    body_hash = ActiveSupport::JSON.decode(body)
    postxml_key = session[:postxml_key] || $postxml_key
    data_hash = Hash.from_xml("<array type='array'>#{body_hash[postxml_key]}</array>")
    return [data_hash['array'][0]['record']['record']].to_json
  end
end
