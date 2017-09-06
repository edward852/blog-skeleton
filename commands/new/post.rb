usage       'post [options]'
summary     'Create a new post'
description 'This command creates a new post with some in-buffer settings filled.'

flag   :h, :help,  'show help for this command' do |value, cmd|
  puts cmd.help
  exit 0
end
option :t, :title, 'specify the title', :argument => :optional

run do |opts, args, cmd|
  title = opts[:title] || 'An Empty Title'
  author = ENV['USER']
  t = Time.now
  timestamp = t.strftime("<%Y-%m-%d %a %H:%M>")
  fname = 'content/posts/'+t.strftime("%Y-%m-%d-")+title.downcase.gsub(/\s+/,'-')+'.org'
  puts "new post with title: #{title} author: #{author} timestamp: #{timestamp}"
  puts "file name: "+fname
  post = File.new(fname, "w:utf-8")
  post.puts "# -*- coding: utf-8 -*-"
  post.puts "#+TITLE:#{title}"
  post.puts "#+AUTHOR:#{author}"
  post.puts "#+DATE:#{timestamp}"
  post.puts "#+UPDATED_AT:#{timestamp}"
  post.puts "#+TAGS:"
  post.puts ""
end

