
# nginx

execute "rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm" do
  not_if "rpm -q nginx-release-centos"
  only_if "grep 'CentOS release 6' /etc/system-release"
end

package "nginx"


remote_file "/etc/nginx/nginx.conf"
remote_file "/etc/nginx/proxy.conf"

execute "chmod -R o-rwx       /etc/nginx"
execute "chown -R nginx:nginx /etc/nginx"

service "nginx" do action [:enable, :start] end

