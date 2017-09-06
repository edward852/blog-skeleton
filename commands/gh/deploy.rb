usage       'deploy'
summary     'GitHub Pages deploy'
description 'This command performs Github Pages deploy action.'

flag   :h, :help,  'show help for this command' do |value, cmd|
  puts cmd.help
  exit 0
end

module Nanoc::CLI::Commands
  class GhDeploy < ::Nanoc::CLI::CommandRunner
    def run
      if !arguments.empty? then
		puts "Invalid input!"
		return
      end

      output = site.config[:output_dir]
      remote = site.config[:deploy][:default][:remote]
      branch = site.config[:deploy][:default][:branch]
      repo = remote.gsub(/^git:/, 'https:').strip
      repo = repo.gsub(%r{https://}, "")

	  puts 'GitHub Pages deploy...'

      if ENV['GH_TOKEN'].nil? then
        puts %x(
             (cd #{output}
             git add --all
             git commit -m "Manually deployed"
             git push --force "#{remote}" "#{branch}"
             )
             )
      else
        puts %x(
             (cd #{output}
             git config user.name ${GIT_NAME}
             git config user.email ${GIT_EMAIL}
             git add --all
             git commit -m "Auto deployed by Travis CI"
             git push --force --quiet "https://${GH_TOKEN}@#{repo}" "#{branch}"
             )
             )
      end
    end
  end
end

runner Nanoc::CLI::Commands::GhDeploy

