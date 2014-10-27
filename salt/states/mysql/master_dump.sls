create dump:
  cmd.run:
    #    - name : "mysqldump --single-transaction --skip-lock-tables --flush-logs --hex-blob --master-data=2 --databases dalmp | gzip > /dump.sql.gz"
    - name : "mysqldump --single-transaction --skip-lock-tables --flush-logs --hex-blob --master-data=2 -A | gzip > /dump.sql.gz"
    - stateful: True
