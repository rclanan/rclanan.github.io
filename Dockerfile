# Dockerfile for jekyll
# https://jekyllrb.com/

FROM rclanan/docker-ruby

MAINTAINER Ray Clanan <rclanan@utopianconcept.com>

RUN gem install \ 
  github-pages \
  jekyll \
  jekyll-redirect-from \
  kramdown \
  rdiscount \
  rouge \
  therubyracer

ADD ./ /data/rclanan.github.io

VOLUME ["/data"]

WORKDIR /data/rclanan.github.io

RUN /bin/bash -l -c "bundle install"

EXPOSE 4000

ENTRYPOINT ["jekyll"]

CMD ["serve","--watch"]
