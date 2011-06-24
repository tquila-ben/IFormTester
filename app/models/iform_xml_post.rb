class IformXmlPost < ActiveRecord::Base
  has_one :iform_test
  before_create '(self.iform_test = IformTest.new).body = data_records'
  
  def header
    iform_test.header
  end
  
  def data_records
    body_hash = ActiveSupport::JSON.decode(body)
    puts "......body_hash[:key]:#{body_hash['key'].inspect}"
    data_hash = Hash.from_xml("<array type='array'>#{body_hash['key']}</array>")
    puts "......data_hash:#{data_hash.inspect}"
    return [data_hash['array'][0]['record']['record']].to_json
  end
end
