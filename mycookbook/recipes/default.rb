execute "upgrade system" do
	command "yum -y update"
	action :run
end
