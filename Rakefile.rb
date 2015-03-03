
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

desc 'Generate site from Travis CI and publish to GitHub Pages.'
task :travis do
  # if this is a pull request, do a simple build of the site and stop
  if ENV['TRAVIS_PULL_REQUEST'].to_s.to_i > 0
    puts 'Pull request detected. Executing build only.'
    sh 'bundle exec rake build'
    next
  end

  repo = %x(git config remote.origin.url).gsub(/^git:/, 'https:').strip
  deploy_url = repo.gsub %r{https://}, "https://#{ENV['GH_TOKEN']}@"
  deploy_branch = repo.match(/github\.io\.git$/) ? 'master' : 'gh-pages'
  rev = %x(git rev-parse HEAD).strip

  Dir.mktmpdir do |dir|
    dir = File.join dir, 'site'
    sh 'bundle exec rake build'
    fail "Build failed." unless Dir.exists? destination
    sh "git clone --branch #{deploy_branch} #{repo} #{dir}"
    sh %Q(rsync -rt --del --exclude=".git" --exclude=".nojekyll" #{destination} #{dir})
    Dir.chdir dir do
      # setup credentials so Travis CI can push to GitHub
      verbose false do
        sh "git config user.name '#{ENV['GIT_NAME']}'"
        sh "git config user.email '#{ENV['GIT_EMAIL']}'"
      end

      sh 'git add --all'
      sh "git commit -m 'Built from #{rev}'."
      verbose false do
        sh "git push -q #{deploy_url} #{deploy_branch}"
      end
    end
  end
end
