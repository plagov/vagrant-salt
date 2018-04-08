nodejs-repo:
  pkgrepo.managed:
    - humanname: NodeJS nodesource repository
    - name: deb https://deb.nodesource.com/node_4.x trusty main
    - key_url: http://deb.nodesource.com/gpgkey/nodesource.gpg.key

nodejs:
  pkg:
    - installed
