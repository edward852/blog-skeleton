usage       'new [item]'
summary     'Create a new item'
description 'This command creates a new item such as post.'

flag   :h, :help,  'show help for this command' do |value, cmd|
  puts cmd.help
  exit 0
end

