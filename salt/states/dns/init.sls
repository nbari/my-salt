/etc/resolv.conf:
  file.managed:
    source: salt://dns/resolv.conf
    user: root
    group: group
    mode: 644
    templage: jinja
