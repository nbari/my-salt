base:
  '*':
    - users
    - schedule
    - headers

  'node_type:test':
    - match: grain
    - users.test
