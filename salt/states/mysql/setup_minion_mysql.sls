/usr/local/etc/salt/minion:
  file:
    - managed
    - source: salt://mysql/minion

salt_minion:
  service:
    - running
    - watch:
      - file: /usr/local/etc/salt/minion
