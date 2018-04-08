hwaas-site:
  user.present:
    - name: hwaas
    - home: /home/hwaas

git-client-package:
  pkg.installed:
    - name: git

hwaas-source:
  git.latest:
    - name: https://github.com/floyd-may/hwaas
    - rev: master
    - target: /home/hwaas/hwaas-site
    - require:
      - user: hwaas-site
      - pkg: git-client-package

npm-strict-ssl-certificate-false:
  cmd.wait:
    - name: npm config set strict-ssl false
    - cwd: /home/hwaas/hwaas-site
    - watch:
      - git: hwaas-source

hwaas-npm-install:
  cmd.wait:
    - name: npm install
    - cwd: /home/hwaas/hwaas-site
    - watch:
      - git: hwaas-source

hwaas-build-script:
  cmd.wait:
    - name: npm run-script build
    - cwd: /home/hwaas/hwaas-site
    - watch:
      - git: hwaas-source
