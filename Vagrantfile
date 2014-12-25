# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  config.vm.define :metrics do |box|
    box.vm.box = "opscode-ubuntu-14.04"
    box.vm.host_name = "influxdb-vm"

    config.vm.synced_folder ENV['HOME'], "/home/chris"

    # config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"


    box.vm.provision :chef_apply do |chef|
      # chef.add_recipe "apt"

      # note that on OS X you can just install from homebrew with 'package'.
      deb = "influxdb_latest_amd64.deb"
      local_file = "/tmp/#{deb}"

      grafana_tar = "grafana-1.9.0.tar.gz"
      grafana_file = "/tmp/#{grafana_tar}"
      nginx_dir = "/usr/share/nginx/html"
      config_js = IO.read("config.js")

      chef.recipe = <<-RECIPE
        remote_file "#{local_file}" do
          source "http://s3.amazonaws.com/influxdb/#{deb}"
        end

        dpkg_package "influxdb" do
          source "#{local_file}"
        end

        service "influxdb" do
          action :enable
        end

        package "nginx"

        remote_file "#{grafana_file}" do
          source "http://grafanarel.s3.amazonaws.com/#{grafana_tar}"
        end

        execute "tar -C #{nginx_dir} -xzf #{grafana_file}"

        execute "mv #{nginx_dir}/grafana-1.9.0 #{nginx_dir}/grafana" do
          not_if { File.directory?("#{nginx_dir}/grafana") }
        end

        file "#{nginx_dir}/config.js" do
          content <<-EOS
          #{config_js}
          EOS
        end
      RECIPE
    end
  end 
end
