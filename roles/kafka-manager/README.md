##What is a kafka Manager?
A tool for managing Apache Kafka.
It supports the following :
- Manage multiple clusters
- Easy inspection of cluster state (topics, brokers, replica distribution, partition distribution)
- Run preferred replica election
- Generate partition assignments with option to select brokers to use
- Run reassignment of partition (based on generated assignments)
- Create a topic with optional topic configs (0.8.1.1 has different configs than 0.8.2+)
- Delete topic (only supported on 0.8.2+ and remember set delete.topic.enable=true in broker config)
- Topic list now indicates topics marked for deletion (only supported on 0.8.2+)
- Batch generate partition assignments for multiple topics with option to select brokers to use
- Batch run reassignment of partition for multiple topics
- Add partitions to existing topic
- Update config for existing topic
- Optionally enable JMX polling for broker level and topic level metrics.


Compiled version of yahoo's [kafka-manager] (https://github.com/yahoo/kafka-manager)
