#!/usr/bin/env ruby
# -*- coding: utf-8; mode: ruby -*-
$: << File.expand_path(File.dirname(__FILE__))

require 'lib/web-socket-ruby/lib/web_socket'

argv = ARGV
if argv.size <= 0
  puts "Please enter your username."
  exit()
end

username = ARGV[0]
unless username =~ /^[a-zA-Z0-9]+$/
  puts "Required username is [a-zA-Z0-9]"
  exit()
end


# クライアント
SERVER = "ws://192.168.3.13:51234"
client = WebSocket.new(SERVER)
client.send("@username: #{username}")

Thread.new() do
  while data = client.receive()
    puts data
  end
  exit()
end

$stdin.each_line() do |line|
  data = line.chomp()
  client.send(data)
end

client.close()
