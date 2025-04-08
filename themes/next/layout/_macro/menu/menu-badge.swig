{% macro render(name) %}

  {% set badges = {
    archives: site.posts.length,
    categories: site.categories.length,
    tags: site.tags.length }
  %}
  {% for menu, count in badges %}
    {% if name == menu %}
      <span class="badge">{{ count }}</span>
    {% endif %}
  {% endfor %}

{% endmacro %}
<div id="music163player">
              <iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=330 height=86 src="//music.163.com/outchain/player?type=2&id=5271400&auto=0&height=66"></iframe>
          </div>