tmux:
  pkg.installed:
    - watch:
      - file: /usr/local/etc/tmux.conf

/usr/local/etc/tmux.conf:
  file:
    - managed
    - source: salt://tmux/tmux.conf
    - mode: 644
