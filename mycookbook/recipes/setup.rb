# this recipe installs some packages
#
#
Chef::Log.info("Running #{recipe_name} recipe in the #{cookbook_name} cookbook.")
group node['apache']['group']
user node['apache']['user'] do
 group node['apache']['group']
 system true
 shell '/bin/bash'
end

package "httpd" do
  action :install
end

service "httpd" do
 action [:enable, :start]
end

directory node['apache']['docroot'] do
        action :create
        recursive true
        mode 0755
        owner node['apache']['user']
        group node['apache']['group']
end
log "MESSAGE: recipe = #{recipe_name} cookbook = #{cookbook_name} - END"
end
Chef::Log.info("#{recipe_name} recipe run in the #{cookbook_name} cookbook complete.")
