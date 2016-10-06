# deploy a simple static html page that lists attribute/databags etc

apache_docroot = node['apache']['docroot']
apache_user = node['apache']['user']
apache_group = node['apache']['group']

stack = search("aws_opsworks_stack").first
instance = search("aws_opsworks_instance").first

mydatabag = search("mybag1").first

app1 = search("aws_opsworks_app","shortname:app1").first
app2 = search("aws_opsworks_app","shortname:app2").first
app3 = search("aws_opsworks_app","shortname:app3").first

template "#{apache_docroot}/index.html" do
	source "index.html.erb"
	mode 0644
	owner  apache_user
	group apache_group
	variables(
		:stack => stack,
		:instance => instance,
		:mydatabag => mydatabag,
		:app1 => app1['deploy'],
		:app2 => app2['deploy'],
		:app3 => app3['deploy']
	)
end
