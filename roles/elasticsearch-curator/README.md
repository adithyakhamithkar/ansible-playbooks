# Overview
Using https://github.com/elastic/curator to delete old indices

Sample execution
```
curator --config hlens-stg/config_file.yml --dry-run hlens-stg/action_file.yml
```

https://www.elastic.co/guide/en/elasticsearch/client/curator/current/singleton-cli.html
CLI examples
```
curator_cli --host localhost show_indices
```
