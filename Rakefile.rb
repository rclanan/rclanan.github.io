require 'rake-jekyll'

##############
# Jekyll tasks
##############

# Usage: rake serve
desc "Serve Jekyll site locally"
task :serve do
  system "bundle exec jekyll serve --no-watch --config _config.dev.yml"
end # task :serve

# Usage: rake build
desc "Build production Jekyll site"
task :build do
  system "bundle exec jekyll build"
end # task :build

# Usage: rake drafts
desc "Build local Jekyll site with _drafts posts"
task :drafts do
  system "bundle exec jekyll build --drafts --config _config.dev.yml"
end # task :drafts

##################
# Production tasks
##################

# Ping Pingomatic
desc 'Ping pingomatic'
task :pingomatic do
  begin
    require 'xmlrpc/client'
    puts '* Pinging ping-o-matic'
    XMLRPC::Client.new('rpc.pingomatic.com', '/').call('weblogUpdates.extendedPing', 'utopianconcept.com' , 'https://utopianconcept.com', 'https://utopianconcept.com/atom.xml')
  rescue LoadError
    puts '! Could not ping ping-o-matic, because XMLRPC::Client could not be found.'
  end
end # task :pingomatic

# Ping Google
desc 'Notify Google of the new sitemap'
task :sitemapgoogle do
  begin
    require 'net/http'
    require 'uri'
    puts '* Pinging Google about our sitemap'
    Net::HTTP.get('www.google.com', '/webmasters/tools/ping?sitemap=' + URI.escape('https://utopianconcept.com/sitemap.xml'))
  rescue LoadError
    puts '! Could not ping Google about our sitemap, because Net::HTTP or URI could not be found.'
  end
end # task :sitemapgoogle

# Ping Bing
desc 'Notify Bing of the new sitemap'
task :sitemapbing do
  begin
    require 'net/http'
    require 'uri'
    puts '* Pinging Bing about our sitemap'
    Net::HTTP.get('www.bing.com', '/webmaster/ping.aspx?siteMap=' + URI.escape('https://utopianconcept.com/sitemap.xml'))
  rescue LoadError
    puts '! Could not ping Bing about our sitemap, because Net::HTTP or URI could not be found.'
  end
end # task :sitemapbing

# Usage: rake notify
desc 'Notify various services about new content'
task :notify => [:pingomatic, :sitemapgoogle, :sitemapbing] do
end # task :notify

desc 'Deploy to github'
Rake::Jekyll::GitDeployTask.new(:deploy) do |t|
  t.deploy_branch = 'master'
end
