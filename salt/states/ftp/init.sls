{% set ftp = salt['grains.filter_by']({
    'Debian': {'pkg': 'pure-ftpd'},
    'FreeBSD': {'pkg': 'pure-ftpd'},
}, default = 'FreeBSD') %}

pure-ftpd:
  pkg.installed:
    - name: {{ ftp.pkg }}
  service:
    - running

/usr/local/etc/pure-ftpd.conf:
  file:
    - managed
    - template: jinja
    - user: root
    - mode: 644
    - source: salt://ftp/pure-ftpd.conf
    - require:
      - pkg: pure-ftpd
