task :default => [:blog]

task :blog do
  system "bundle exec nanoc gh setup"
  ret = system "bundle exec nanoc"
  system "bundle exec nanoc gh deploy" unless ret==false
end
