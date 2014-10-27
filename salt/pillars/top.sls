base:
  '*':
    - users
    - schedule

  'node_type:test':
    - match: grain
    - users.test
