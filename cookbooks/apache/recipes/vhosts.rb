data_bag("vhosts").each do |site|
  site_data = data_bag_item("vhosts", site)
  site_name = site_data["id"]
  document_root = "/srv/apache/#{site_name}"
  
  template "/etc/apache2/sites-available/#{site_name}" do
    source "custom-vhosts.erb"
    mode "0644"
    variables(
      :document_root => document_root,
      :port => site_data["port"]
    )
  end
  
  execute "a2ensite #{site_name}" do
    not_if do
      ::File.symlink?("/etc/apache2/sites-enabled/#{site_name}")
    end
    notifies :restart, "service[apache2]"
  end
  
  directory document_root do
    mode "0755"
    recursive true
  end
  
  template "#{document_root}/index.html" do
    source "index.html.erb"
    mode "0644"
    variables(
      :site_name => site_name,
      :port => site_data["port"]
    )
  end
  
end