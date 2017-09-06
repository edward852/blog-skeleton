usage       'setup'
summary     'GitHub Pages setup'
description 'This command performs Github Pages setup action.'

flag   :h, :help,  'show help for this command' do |value, cmd|
  puts cmd.help
  exit 0
end

module Nanoc::CLI::Commands
  class GhSetup < ::Nanoc::CLI::CommandRunner
    def run
      if !arguments.empty? then
		puts "Invalid input!"
		return
      end

      output = site.config[:output_dir]
      remote = site.config[:deploy][:default][:remote]
      branch = site.config[:deploy][:default][:branch]

	  puts 'GitHub Pages setup...'

	  FileUtils.rm_r(output) unless !Dir.exist?(output)
	  Dir.mkdir(output)

	  puts %x(
		git clone --branch "#{branch}" "#{remote}" "#{output}"
		)
    end
  end
end

runner Nanoc::CLI::Commands::GhSetup

