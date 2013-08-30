my-vim:
  git.latest:
    - name: https://github.com/nbari/my-vim
    - target: /usr/local/share/my-vim
    - rev: master
    - submodules: True
  cmd.wait:
    - name: 'cd /usr/local/share/my-vim; git submodule init; git submodule foreach git pull origin master; git submodule update'
    - watch:
      - git: my-vim
