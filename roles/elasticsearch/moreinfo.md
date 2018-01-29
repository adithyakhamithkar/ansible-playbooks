#
## Indices
An index power search into all documents within a collection of types. They contain inverted indices that let you search across everything within them at once.

## Types
A type defines the schema and mapping shared by documents that represent the same sort of things. (A log entry, an encyclopedia article, etc.)

## Documents
Documents are the things you're searching for. They can be more than text - any structured JSON data works. Every document has a unique ID, and a type.

TF-IDF means terms frequency * inverse document frequency
Term frequency is how often a term appears in a given document
Document frequency is how often a term appears in all documents
Term frequency/document frequency measure the relevance of a term in a document

## More on index
An index is like a ‘database’ in a relational database. It has a mapping which defines multiple types.
An index is a logical namespace which maps to one or more primary shards and can have zero or more replica shards.
Data in Elasticsearch is organized into indices. Each index is made up of one or more shards. Each shard is an instance of a Lucene index, which you can think of as a self-contained search engine that indexes and handles queries for a subset of the data in an Elasticsearch cluster.

As data is written to a shard, it is periodically published into new immutable Lucene segments on disk, and it is at this time it becomes available for querying. This is referred to as a refresh. How this works is described in greater detail in Elasticsearch: the Definitive Guide.
https://www.elastic.co/blog/what-is-an-elasticsearch-index
https://www.elastic.co/blog/how-many-shards-should-i-have-in-my-elasticsearch-cluster

## Primary shards
https://www.elastic.co/guide/en/elasticsearch/guide/current/_how_primary_and_replica_shards_interact.html
You can only define the number of primary shards while creating an index
Primary shards are for write
And replica shards are for read, these can be expanded
It's a good practice to have min 2 primary shards and 2 replica for active fail over. In this case you need to have an odd number of data nodes.
In case you need to add more primary shards you need to reindex the data and copy that into a new index.
Calculating primary and replica shards
(number of primary shards * replica shards) + primary shards = total number of shards

## versions
Every document has a `_version` field
Elasticsearch documents are immutable
When you update an existing document a new document is created with an incremented `_version` the old document is marked for deletion.

# concurrency control
Use `retry_on_conflict=N`
https://www.elastic.co/blog/elasticsearch-versioning-support

https://thoughts.t37.net/an-elasticsearch-cheat-sheet-9b92c9211d7b

https://qbox.io/tutorials
