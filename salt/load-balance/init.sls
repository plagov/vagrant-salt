nginx:
  pkg.installed: []
  service.running:
    - watch:
      - file: /etc/nginx/conf.d/load-balancer.conf
      - file: remove-default-sites
      - file: {{ pillar['hwaas-ssl']['cert-path'] }}
      - file: {{ pillar['hwaas-ssl']['cert-key-path'] }}


/etc/nginx/conf.d/load-balancer.conf:
  file.managed:
    - source: salt://load-balance/load-balancer.conf
    - require:
      - pkg: nginx
    - template: jinja

remove-default-sites:
  file.absent:
    - name: /etc/nginx/sites-enabled/default
    - require:
      - file: /etc/nginx/conf.d/load-balancer.conf

{{ pillar['hwaas-ssl']['cert-path'] }}:
  file.managed:
    - contents_pillar: hwaas-ssl:cert-contents

{{ pillar['hwaas-ssl']['cert-key-path'] }}:
  file.managed:
    - contents_pillar: hwaas-ssl:cert-key-contents
