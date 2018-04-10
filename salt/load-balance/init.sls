nginx:
  pkg.installed: []
  service.running:
    - watch:
      - file: /etc/nginx/conf.d/load-balancer.conf
      - file: remove-default-sites


/etc/nginx/conf.d/load-balancer.conf:
  file.managed:
    - source: salt://load-balance/load-balancer.conf
    - require:
      - pkg: nginx

remove-default-sites:
  file.absent:
    - name: /etc/nginx/sites-enabled/default
    - require:
      - file: /etc/nginx/conf.d/load-balancer.conf
