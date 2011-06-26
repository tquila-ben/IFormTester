# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Iformtester::Application.initialize!

$iformbuilder_uri = "http://acpt.iformbuilder.com/p/chrisdemo/exzact/dataXML.php?PAGE_ID=7206&TABLE_NAME=_data10984_profile&USERNAME=aleung&PASSWORD=iform2011"
$amortization_rest_uri = 'http://localhost:4567/create_report'
$amortization_xmlrpc_uri = 'http://184.168.105.16:4567/xmlrpc'
#$amortization_xmlrpc_uri = 'http://localhost:4567/xmlrpc'