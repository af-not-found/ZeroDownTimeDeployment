
# OS & java

service "iptables"  do action [:stop, :disable] end

execute "setenforce permissive"
file "/etc/selinux/config" do
  action :edit
  block do |content|
    content.gsub!("^SELINUX=enforcing", "SELINUX=permissive")
  end
end

package "epel-release"
package "git"

execute "yum -y --enablerepo epel install java-1.8.0-openjdk-devel" do
  not_if "rpm -qa | grep openjdk-devel"
end

execute "rpm -ivh --nodeps https://repos.fedorapeople.org/repos/dchen/apache-maven/apache-maven-3.3.3-4.el6.noarch.rpm" do
  not_if "rpm -qa | grep apache-maven"
end
