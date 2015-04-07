mine_functions:
  uname:
    - mine_function: cmd.run
    - 'uname -a'
  vmstat:
    - mine_function: cmd.run
    - vmstat
  ps:
    - mine_function: cmd.run
    - 'ps -aux'
  top:
    - mine_function: cmd.run
    - 'top -b'
  test.ping: []
  network.ip_addrs:
    cidr: '10.15.0.0/16'
  status.uptime: []
