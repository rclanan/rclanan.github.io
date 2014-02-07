require "rubygems"
require 'rake'
require 'yaml'
require 'time'
require 'open-uri'
require 'RMagick'
require "digest/md5"
require "tmpdir"
require "bundler/setup"
require "jekyll"

SOURCE = "."
CONFIG = {
  'layouts' => File.join(SOURCE, "_layouts"),
  'posts' => File.join(SOURCE, "_posts")
}

GITHUB_REPONAME = "rclanan/rclanan.github.io"

###
# Based on jekyll-bootstrap's Rakefile.
# Thanks, @plusjade
# https://github.com/plusjade/jekyll-bootstrap
###
#
#
def say_what? message
  print message
  STDIN.gets.chomp
end

def sluggize str
  str.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/^-|-$/, '');
end

# Usage: rake post title="A Title" [date="2012-02-09"]
desc "Begin a new post in #{CONFIG['posts']}"
task :post do
  abort("rake aborted: '#{CONFIG['posts']}' directory not found.") unless FileTest.
    directory?(CONFIG['posts'])
  title = ENV["title"] || "new-post"
  slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  begin
    date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
  rescue Exception => e
    puts "Error - date format must be YYYY-MM-DD, please check you typed it correctly!"
    exit -1
  end
  filename = File.join(CONFIG['posts'], "#{date}-#{slug}.md")
  if File.exist?(filename)
    abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?",
      ['y', 'n']) == 'n'
  end

  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "layout: post"
    post.puts "title: \"#{title.gsub(/-/,' ')}\""
    post.puts "category: posts"
    post.puts "---"
  end
end # task :post

desc "Launch preview environment"
task :preview do
  system "jekyll serve --watch"
end # task :preview

desc "Update icons based on your gravatar (define author email in _config.yml)!"
task :icons do
  puts "Getting author email from _config.yml..."
  config = YAML.load_file('_config.yml')
  author_email = config['author']['email']
  gravatar_id = Digest::MD5.hexdigest(author_email)
  base_url = "http://www.gravatar.com/avatar/#{gravatar_id}?s=150"

  origin = "origin.png"
  File.delete origin if File.exist? origin

  puts "Downloading base image file from gravatar..."
  open(origin, 'wb') do |file|
    file << open(base_url).read
  end

  name_pre = "apple-touch-icon-%dx%d-precomposed.png"

  FileList["*apple-touch-ico*.png"].each do |img|
    File.delete img
  end

  FileList["*favicon.ico"].each do |img|
    File.delete img
  end

  puts "Creating favicon.ico..."
  Magick::Image::read(origin).first.resize(16, 16).write("favicon.ico")

  [144, 114, 72, 57].each do |size|
    puts "Creating #{name_pre} icon..." % [size, size]
    Magick::Image::read(origin).first.resize(size, size).
      write(name_pre % [size, size])
  end
  puts "Cleaning up..."
  File.delete origin
end

desc "Generate blog files"
task :generate do
  Jekyll::Site.new(Jekyll.configuration({
    "source"      => ".",
    "destination" => "_site"
  })).process
end

desc "Generate and publish blog to gh-pages"
task :publish => [:generate] do
  Dir.mktmpdir do |tmp|
    cp_r "_site/.", tmp

    pwd = Dir.pwd
    Dir.chdir tmp

    system "git init"
    system "git add ."
    message = "Site updated at #{Time.now.utc}"
    system "git commit -m #{message.inspect}"
    system "git remote add origin git@github.com:#{GITHUB_REPONAME}.git"
    system "git push origin master --force"

    Dir.chdir pwd
  end
end

desc "Create a new post"
task :new do
  title     = say_what?('Title: ')
  filename  = "_posts/#{Time.now.strftime('%Y-%m-%d')}-#{sluggize title}.md"

  if File.exist? filename
    puts "Can't create new post: \e[33m#{filename}\e[0m"
    puts "  \e[31m- Path already exists.\e[0m"
    exit 1
  end

  File.open(filename, "w") do |post|
    post.puts "---"
    post.puts "layout:    post"
    post.puts "title:     #{title}"
    post.puts "---"
    post.puts ""
    post.puts "Once upon a time..."
  end

  puts "A new post was created for at:"
  puts "  \e[32m#{filename}\e[0m"
end

desc "Sync assets with s3"
task :asset_sync do
  puts "## Syncing assets..."

  # Weird variable to set, but it turns on AssetSync logging
  ENV['RAILS_GROUPS'] = "assets"

  # Setup AssetSync
  AssetSync.configure do |config|
    config.enabled = true                     # Needs to be set, disabled by default
    config.gzip_compression = true            # Compresses the files before uploading, if not already compressed
    config.existing_remote_files = 'keep'     # Keeps the old versions online. Necessary when working before deploying
    config.fog_provider = 'AWS'               # There are others, I use S3
    config.fog_directory = 'www.utopianconcept.com'
    config.aws_access_key_id = 'key'
    config.aws_secret_access_key = 'secret'
    config.prefix = 'assets'             # Same as jekyll-asset setup in _config.yml
    config.public_path = Pathname('./public') # Should always be this
  end

  # Do the work
  AssetSync.sync
end

desc "Generate website and sync s3 servers"
  task :gen_sync => [:generate, :asset_sync] do
end
