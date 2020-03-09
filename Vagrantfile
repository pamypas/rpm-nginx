MACHINES = {
  :"rpm-homework" => {
              :box_name => "jikarto/centos-nginx-rpm",
              :cpus => 2,
              :memory => 4096,
              :net => [],
              :forwarded_port => []
            }
}

Vagrant.configure("2") do |config|
  MACHINES.each do |boxname, boxconfig|
    config.vm.box = "jikarto/centos-nginx-rpm"
    config.vm.synced_folder ".", "/vagrant", disabled: true
    config.vm.box_version = "0"
    config.vm.define boxname do |box|
      box.vm.box = boxconfig[:box_name]
      box.vm.host_name = boxname.to_s
      if boxconfig.key?(:net)
        boxconfig[:net].each do |ipconf|
          box.vm.network "private_network", ipconf
        end
      end
      if boxconfig.key?(:forwarded_port)
        boxconfig[:forwarded_port].each do |port|
          box.vm.network "forwarded_port", port
        end
      end
      box.vm.provider "virtualbox" do |v|
        v.memory = boxconfig[:memory]
        v.cpus = boxconfig[:cpus]
      end
      box.vm.provision "shell", inline: <<-SHELL
	nginx -V
        yum list installed percona-release
      SHELL
    end
  end
end
