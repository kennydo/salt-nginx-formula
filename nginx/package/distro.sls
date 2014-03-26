{% from "nginx/map.jinja" import nginx with context %}

include:
  - nginx.package

distro_nginx_package:
  pkg.installed:
    - name: {{ nginx.package }}
    - require_in:
      - service: nginx_service
