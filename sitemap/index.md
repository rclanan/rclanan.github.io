---
layout: archive
title: "Sitemap"
date: 2015-03-01
modified: 2015-03-01
excerpt: "A visual sitemap of utopianconcept.com"
share: false
---

For you robots out there an [XML version]({{ site.url }}/sitemap.xml) is available for digesting.

<div class="sitemap">
  <ul id="primaryNav" class="col6">
    <li id="home"><a href="{{ site.url }}/">Home</a></li>
    <li><a href="{{ site.url }}/about/">About</a>
      <ul>
        <li><a href="{{ site.url }}/subscribe/">Subscribe</a></li>
        <li><a href="{{ site.url }}/support/">Support</a></li>
        <li><a href="{{ site.url }}/terms/">Terms</a></li>
      </ul>
    </li>
    <li><a href="#archives">Archives</a>
      <ul>
        <li><a href="#archives-year">Archives by Year</a>
          <ul>
            <li><a href="{{ site.url }}/2015/">2015</a></li>
            <li><a href="{{ site.url }}/2013/">2013</a></li>
          </ul>
        </li>
        <li><a href="{{ site.url }}/tag/">Archives by Tag</a>
          <ul>
            {% assign tags_list = site.tags | sort %}
            {% for tag in tags_list %}
            <li><a href="{{ site.url }}/tag/{{ tag[0] | replace:' ','-' | downcase }}/">{{ tag[0] }}</a></li>
            {% endfor %}
          </ul>
        </li>
      </ul>
    </li>
    <li><a href="{{ site.url }}/articles/">Articles</a>
      <ul>
        {% for post in site.categories.articles %}
        {% include post-list.html %}
        {% endfor %}
      </ul>
    </li>
    <li><a href="{{ site.url }}/screencast/">Screencast</a>
      <ul>
        {% for post in site.categories.screencast %}
        {% include post-list.html %}
        {% endfor %}
      </ul>
    </li>
    <li><a href="{{ site.url }}/work/">Work</a>
      <ul>
        {% for post in site.categories.work %}
        {% include post-list.html %}
        {% endfor %}
      </ul>
    </li>
  </ul><!-- /.col5 -->
</div><!-- /.sitemap -->
