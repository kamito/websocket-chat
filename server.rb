#!/usr/bin/env ruby
# -*- coding: utf-8; mode: ruby -*-

# サーバー

require 'em-websocket'
require 'fileutils'


HOST = "192.168.3.18"
PORT = 51234

LOGDIR = File.expand_path(File.join(File.dirname(__FILE__), 'logs'))
FileUtils.makedirs(LOGDIR) unless File.exists?(LOGDIR)

Process.daemon(nochdir=true) if ARGV[0] == "-D"
connections = Hash.new
now = Time.now
logpath = File.join(LOGDIR, "#{now.strftime('%Y%m%d%H%M%S')}.#{now.usec}.log")

options = {
  :host => HOST,
  :port => PORT,
}
EventMachine::WebSocket.start(options) do |ws|
  username = nil

  ws.onopen do
    ws.send "Connected session."
  end

  ws.onmessage do |msg|
    m = msg.match(/^@username:\s([a-zA-Z0-9]+)$/)
    if m
      username = m[1]
      connections[username] = ws unless connections.key?(username)
      msg = "Loggedin #{username}"
    else
      now = Time.now.strftime("%H:%M:%S")
      msg = "[#{now}] #{username.ljust(10)}: #{msg}"
    end
    puts "#{msg}"
    File.open(logpath, 'a') do |io|
      io << "#{msg}\n"
    end

    ws.send(msg) #to myself
    connections.each do |username, con|
      #to other people
      con.send(msg) unless con == ws
    end
  end

  ws.onclose do
    puts "Closed session."
  end
end
