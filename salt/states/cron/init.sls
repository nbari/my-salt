# using scheduler
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin salt-call state.highstate > /tmp/crontest:
  cron.absent:
    - identifier: HIGHSTATE
    - user: root
    - minute: '*/5'

# restart every week on sundays at 4am UTC
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin service salt_minion restart:
  cron.present:
    - identifier: RESTART
    - user: root
    - minute: 0
    - hour: 4
    - dayweek: 0
