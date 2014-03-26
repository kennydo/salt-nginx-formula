{% from "nginx/map.jinja" import nginx with context %}

nginx_service:
    service.running:
        - enable: True
        - name: {{ nginx.service }}
