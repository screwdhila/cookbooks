#configure apache
Chef::Log.info("Running #{recipe_name} recipe in the #{cookbook_name} cookbook.")
apache_user = node['apache']['user']
apache_group = node['apache']['group']
apache_docroot = node['apache']['docroot']
apache_errorlog = node['apache']['error_log']
apache_accesslog = node['apache']['access_log']
instance_details = search("aws_opsworks_instance").first
instance_hostname = instance_details['hostname']

service "httpd" do
 action [:start]
end

template "/etc/httpd/conf/httpd.conf" do
	source "httpd.conf.erb"
	mode 0644
	owner 'root'
	group 'root'
	variables(
		:user => apache_user,
		:group => apache_group,
		:docroot => apache_docroot,
		:errorlog => apache_errorlog,
		:accesslog => apache_accesslog,
		:servername => instance_hostname
	)
	notifies :restart, "service[httpd]"
end
Chef::Log.info("#{recipe_name} recipe run in the #{cookbook_name} cookbook complete.")
