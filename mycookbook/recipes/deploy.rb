# deploy a simple static html page that lists attribute/databags etc
log 'Start' do
  message "MESSAGE: cookbook = #{cookbook_name}  recipe = #{recipe_name}  - START"
  level :info
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
log 'End' do
  message "MESSAGE: cookbook = #{cookbook_name}  recipe = #{recipe_name}  - END"
  level :info
end
