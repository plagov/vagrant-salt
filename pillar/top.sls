base:
  '*':
    - common

  'loadbalancer':
    - override
  'roles:load-balancing':
    - match: grain
    - hwaas-sls
