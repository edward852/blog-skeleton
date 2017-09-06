usage       'gh [action]'
summary     'GitHub Pages related action'
description 'This command performs action related to Github Pages such as setup or deploy.'

flag   :h, :help,  'show help for this command' do |value, cmd|
  puts cmd.help
  exit 0
end

