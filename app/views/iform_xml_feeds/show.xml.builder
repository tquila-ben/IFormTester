xml.instruct!
xml.aaData do

    record_location = @iform_xml_feed['_data10984_profile']
        
    xml.location_type iform_xml_feed['type']
    xml.id record_data['id']
    xml.created_date record_data['created_date']
    xml.latitude created_location[0]
    xml.longitude created_location[1]
    xml.altitude created_location[2]
    xml.horizontalAccuracy created_location[3]
    xml.verticalAccuracy created_location[4]
    xml.speed created_location[5]
    xml.course created_location[6]
    xml.timestamp created_location[7]

end