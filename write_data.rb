#!/usr/bin/env ruby

require "influxdb"

host = "192.168.11.10"
db = "metricsdb"

client = InfluxDB::Client.new db, host: host
client.create_database db rescue nil

ct = 3600
values = (0..ct).to_a.map {|i| Math.send(:sin, i / 10.0) * 10 }.each

types = %w{orange yellow green}

values.each_with_index do |v, i|
  data = {
    value: v,
    machine_class: types[i % 3]
  }
  client.write_point "sine", data
  puts "#{i} of #{ct}" if i % 20 == 0
  sleep 1
 end