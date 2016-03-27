---
layout: archive
permalink: /
title: "The digital grind"
excerpt: "Another day, another byte processed"
image:
  feature: coding-macbook.jpg
  credit: Provided by StockSnap.io
  creditlink: https://stocksnap.io/photo/LV2IUQNTZ5
id: home
---

Utopian Concept is the personal website of Ray Clanan. I am a polyglot programmer, father of two, typical computer nerd from Indianapolis, Indiana.
{:.shorten}

Below you will find a selection of my most recent blog posts, screencasts, and work.
{:.shorten}

<nav class="toc toc-left">
<ul>
  <li><h6><a href="{{ site.url }}/articles/">A Blog of Sorts <i class="fa fa-long-arrow-right"></i></a></h6></li>
  <li><a href="{{ site.url }}/tag/">Tag Archive</a></li>
  <li><a href="{{ site.url }}/2016/">Posts from 2016</a></li>
  <li><a href="{{ site.url }}/2015/">Posts from 2015</a></li>
  <li><a href="{{ site.url }}/2013/">Posts from 2013</a></li>
</ul>
</nav><!-- /.toc-left -->

<div class="tiles tiles-3-4">
{% for post in site.categories.articles limit:4 %}
  {% include post-grid.html %}
{% endfor %}
</div><!-- /.tiles-3-4 -->

<nav class="toc toc-left">
<ul>
  <li><h6><a href="{{ site.url }}/work/">Work I've Done <i class="fa fa-long-arrow-right"></i></a></h6></li>
  {% for post in site.categories.work limit:6 %}
    <li><a href="{{ site.url }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
  {% for contribution in site.data.opensource limit:6 %}
    <li><a href="{{ contribution.url }}">{{ contribution.title }}</a></li>
  {% endfor %}
</ul>
</nav><!-- /.toc-left -->

<div class="tiles tiles-3-4">
{% for post in site.categories.work limit:6 %}
  {% include post-grid.html %}
{% endfor %}
{% for contribution in site.data.opensource limit:6 %}
  {% include contribution-grid.html %}
{% endfor %}
</div><!-- /.tiles-3-4 -->

<div class="tiles">
<h2>Clients</h2>
{% for client in site.data.clients %}
  {% include client-grid.html %}
{% endfor %}
</div><!-- /.tiles -->
