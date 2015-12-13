
# Spring Boot application

execute "adduser zdtd" do
  not_if "grep -E \"^zdtd:\" /etc/passwd"
end

directory "/var/run/zdtd-8080" do
  owner "zdtd"
  group "zdtd"
  mode "770"
end

directory "/var/run/zdtd-8081" do
  owner "zdtd"
  group "zdtd"
  mode "770"
end

remote_directory "/var/zdtd" do
  source "files/var/zdtd"
  owner "zdtd"
  group "zdtd"
end


execute "git clone https://github.com/af-not-found/ZeroDownTimeDeployment.git" do
  cwd "/var/zdtd"
  user "zdtd"
end

execute "mvn clean install spring-boot:repackage -Dmaven.test.skip=true" do
  cwd "/var/zdtd/ZeroDownTimeDeployment"
  user "zdtd"
end

execute "cp -f /var/zdtd/ZeroDownTimeDeployment/target/zdtd.jar /var/zdtd/zdtd-current.jar" do
  user "zdtd"
end


execute "ln -f /var/zdtd/zdtd-current.jar /var/zdtd/zdtd-8080.jar"
execute "ln -f /var/zdtd/zdtd-current.jar /var/zdtd/zdtd-8081.jar"

execute "chmod -R o-rwx     /var/zdtd"
execute "chown -R zdtd:zdtd /var/zdtd"


execute "ln -sf /var/zdtd/zdtd-8080.jar /etc/init.d/zdtd-8080"
execute "ln -sf /var/zdtd/zdtd-8081.jar /etc/init.d/zdtd-8081"

service "zdtd-8080" do action [:enable, :start] end
service "zdtd-8081" do action [:enable] end


