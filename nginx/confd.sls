{% from "nginx/map.jinja" import nginx with context %}

include:
  - nginx.package

nginx_confd:
  file.directory:
    - name: {{ nginx.confd_directory }}
    - clean: true
    - watch_in:
        - service: nginx_service

{% for filename in pillar.get('nginx_confd', []) %}
{{ nginx.confd_directory }}/{{ filename }}:
  file.managed:
    - name: {{ nginx.confd_directory }}/{{ filename }}
    - source: {{ nginx.config_src }}
    - template: jinja
    - context:
        config_pillar_get_path: 'nginx_confd:{{ filename }}'
    - user: {{ nginx.user }}
    - group: {{ nginx.group }}
    - mode: 644
    - require_in:
      - file: nginx_confd
    - watch_in:
      - service: nginx_service

{% endfor %}
