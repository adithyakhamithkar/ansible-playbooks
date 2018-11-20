## InfluxDB Cheatsheet

### Connect to InfluxDB using the commandline:

    $ influx

### Create a database foo:

    CREATE DATABASE foo

###  List the databases:

    SHOW DATABASES

### Select the new created database:

    USE foo

### List measurements

    SHOW MEASUREMENTS

### Show measurements for name: mars

    SELECT * FROM mars

### Drop mars measurements

    DROP MEASUREMENT mars

### Show field keys

    SHOW FIELD KEYS FROM "mars-A6"
