class IformXmlFeed < ActiveRecord::Base
  has_many :next_steps
  
  def get_request_attributes
    aaData = self.body    
    data_hash = Hash.from_xml("<array type='array'>#{aaData}</array>")
    records = data_hash['array'][0]['record']    
    records = records.select{|record| !record['ID'].nil? }
    records.each{|record_data|
      record_data['interest_only_loan'] = record_data['interest_only']
      record_data['gse_loan'] = record_data['gse']
      record_data['insurance_permiums'] = record_data['insurance_premiums']
      record_data['ctia'] = record_data['monthly_tax_insurance_andor_hoa']
      record_data['mfee'] = record_data['m_fee']
      record_data['miPartialClaim'] = record_data['mi_partial_claim']
      record_data['remaining_terms'] = record_data['remaining_term']
      record_data['months_lpi_to_reo'] = record_data['months_from_lpi_until_reo_sale']
      record_data.delete('CREATED_DATE')
      record_data.delete('CREATED_BY')
      record_data.delete('MODIFIED_BY')
      record_data.delete('MODIFIED_LOCATION')
      record_data.delete('PARENT_RECORD_ID')
      record_data.delete('MODIFIED_DEVICE_ID')
      record_data.delete('PARENT_PAGE_ID')
      record_data.delete('PARENT_ELEMENT_ID')
      record_data.delete('CREATED_DEVICE_ID')
      record_data.delete('MODIFIED_DATE')
      record_data.delete('ID')
      record_data.delete('CREATED_LOCATION')
      record_data.delete('m_fee')
      record_data.delete('interest_only')
      record_data.delete('mi_partial_claim')
      record_data.delete('gse')
      record_data.delete('insurance_premiums')
      record_data.delete('monthly_tax_insurance_andor_hoa')
      record_data.delete('remaining_term')
      record_data.delete('months_from_lpi_until_reo_sale')
      record_data['gross_income'] = 5000
    }
    return records
  end
end
