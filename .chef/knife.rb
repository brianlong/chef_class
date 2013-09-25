# See http://docs.opscode.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "brianlong"
client_key               "#{current_dir}/brianlong.pem"
validation_client_name   "firstmoversadvantage-validator"
validation_key           "#{current_dir}/firstmoversadvantage-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/firstmoversadvantage"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
