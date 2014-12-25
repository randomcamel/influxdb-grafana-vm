influxdb-grafana-vm
===================

Files to set up InfluxDB and Grafana in a Vagrant VM.

Usage:

    vagrant up

This is unlikely to JFW in your environment. You'll likely want to tweak the following:

- The Vagrant box is hardcoded as "opscode-ubuntu-14.04." Pretty sure it's public, but really any Debian- family distro should work fine.

- Hardcoded IP in all the scripts. (If no one else has 192.168.11.10, you're all set.)

- Hardcoded Mac OS X wifi network interface name.

