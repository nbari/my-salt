# create the /tmp/text.txt file if not exists and append date
{% set time_date = salt['cmd.run']('date -u') %}

/tmp/test.txt:
  file:
    - append
    - text:  |
        test 5
        {{ time_date }}
    - require:
      - file: test_file

test_file:
  file:
    - touch
    - name: /tmp/test.txt
