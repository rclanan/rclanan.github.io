---
layout: archive
title: "Work"
date: 2015-03-01
modified: 2015-03-01
excerpt: "A small selection of things I’ve developed or contributed to."
---

<div class="tiles">
{% for post in site.categories.work %}
  {% include post-grid.html %}
{% endfor %}
</div><!-- /.tiles -->
