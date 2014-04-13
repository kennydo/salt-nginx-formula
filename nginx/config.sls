{% from "nginx/map.jinja" import nginx with context %}

include:
  - nginx.package

nginx_config:
  file.managed:
    - name: {{ nginx.config }}
    - source: {{ nginx.config_src }}
    - template: jinja
    - context:
        config_pillar_get_path: "nginx_config"
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: nginx_service
