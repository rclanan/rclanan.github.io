From rclanan/docker-jekyll-bundler

CMD ["bundle exec jekyll serve --port 4000 --host 0.0.0.0 --watch --drafts --force_polling --config _config.dev.yml"]
