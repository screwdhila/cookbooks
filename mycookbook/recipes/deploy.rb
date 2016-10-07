# deploy a simple static html page that lists attribute/databags etc
Chef::Log.info("Running #{recipe_name} recipe in the #{cookbook_name} cookbook.")
log "MESSAGE: recipe = #{recipe_name} cookbook = #{cookbook_name} - START"
end

apache_docroot = node['apache']['docroot']
apache_user = node['apache']['user']
apache_group = node['apache']['group']

stack = search("aws_opsworks_stack").first
instance = search("aws_opsworks_instance").first

mydatabag = search("mybag1").first

template "#{apache_docroot}/index.html" do
	source "index.html.erb"
	mode 0644
	owner  apache_user
	group apache_group
	variables(
		:stack => stack,
		:instance => instance,
		:mydatabag => mydatabag,
		)
end
log "MESSAGE: recipe = #{recipe_name} cookbook = #{cookbook_name} - END"
end
Chef::Log.info("#{recipe_name} recipe run in the #{cookbook_name} cookbook complete.")
