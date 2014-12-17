/usr/local/etc/pkg/repos/FreeBSD.conf:
  file:
    - managed
    - makedirs: True
    - template: jinja
    - user: root
    - mode: 644
    - source: salt://poudriere/files/FreeBSD.conf

/usr/local/etc/pkg/repos/poudriere.conf:
  file:
    - managed
    - makedirs: True
    - template: jinja
    - user: root
    - mode: 644
    - source: salt://poudriere/files/poudriere.conf

/usr/local/etc/ssl/certs/pkg.cert:
  file:
    - managed
    - makedirs: True
    - template: jinja
    - user: root
    - mode: 644
    - source: salt://poudriere/files/pkg.cert
