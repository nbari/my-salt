/etc/resolv.conf:
  file:
    - managed
    - source: salt://dns/resolv.conf
    - user: root
    - mode: 644
    - templage: jinja
