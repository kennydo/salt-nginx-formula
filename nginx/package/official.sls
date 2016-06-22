{% from "nginx/map.jinja" import nginx, nginx_repo with context %}

include:
  - nginx.package

{% if grains['os_family'] == 'RedHat' %}
/etc/pki/rpm-gpg/RPM-GPG-KEY-nginx:
  file.managed:
    - source: http://nginx.org/keys/nginx_signing.key
    - source_hash: md5=016d27313adbf180e545ae9fadd11826
    - user: root
    - group: root
    - mode: 644
    - require_in:
      - pkgrepo: nginx_repo
{% endif %}

nginx_repo:
  pkgrepo.managed:
    {% if grains['os_family'] == 'Debian' %}
    - name: {{ nginx_repo.name }}
    - key_url: {{ nginx_repo.key_url }}
    {% elif grains['os_family'] == 'RedHat' %}
    - name: {{ nginx_repo.name }}
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-nginx
    - humanname: {{ nginx_repo.humanname }}
        {% if 'mirrorlist' in nginx_repo %}
    - mirrorlist: {{ nginx_repo.mirrorlist }}
        {% else %}
    - baseurl: {{ nginx_repo.baseurl }}
        {% endif %}
    {% endif %}
    - require_in:
      - pkg: nginx_nginx_package

nginx_nginx_package:
  pkg.installed:
    - name: nginx
    - require_in:
      - service: nginx_service
