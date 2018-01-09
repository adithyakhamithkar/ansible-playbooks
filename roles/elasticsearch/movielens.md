# Exercise
Download a movielens collection
```
wget http://files.grouplens.org/datasets/movielens/ml-latest-small.zip
```
Create a mapping using the below json in movies-mapping.json

```
{
        "mappings" : {
                "movie" : {
                        "_all":{"enabled": false},
                        "properties":{
                          "id":{"type":"integer"},
                          "year":{"type":"date"},
                          "genre":{"type":"string", "index": "not_analyzed"},
                          "title":{"type":"string", "analyzer":"english"}
                        }                        
                }
        }
}
```
Import the mapping
```
curl -XPUT localhost:9200/movies --data-binary @movies-mapping.json
```
Verify mapping
```
curl -XGET 'http://localhost:9200/movies/_mapping?pretty'
```
Add a entry in the index
```
curl -XPUT 'localhost:9200/movies/movie/109487' -d '{
    "genre": ["IMAX","Sci-Fi"],
    "title": "Intersteller",
    "year": 2014
}'
```
Import build from wget http://media.sundog-soft.com/es/movies.json
```
curl -XPOST 'localhost:9200/movies/_bulk' --data-binary @movies.json
```
Update an existing document
```
curl -XPOST localhost:9200/movies/movie/109487/_update -d '
{
  "doc":{
    "title":"Intersteller 2"
  }
}
'
```
Delete a document
```
curl -XDELETE localhost:9200/movies/movie/109487
```

# Parent child

Create a mapping using the below json in series-matching.json

```
{
        "mappings" : {
                "franchise" : {},
                "film":{
                  "_parent":{
                    "type":"franchise"
                    }
                  }                        
          }
}

```
Import the mapping
```
curl -XPUT localhost:9200/series --data-binary @series-matching.json
```
Import build from wget http://media.sundog-soft.com/es/series.json
```
curl -XPOST 'localhost:9200/movies/_bulk' --data-binary @series.json
```
Search based on Parent
```
curl -H 'Content-Type: application/json' -XGET 'localhost:9200/series/_search?pretty' -d '
{
"query" : {
        "has_parent":{
          "type":"franchise",
          "query":{
              "match":{
                "title":"Star Wars"
              }
          }
        }
  }
}'
```
Search based on child
```
curl -H 'Content-Type: application/json' -XGET 'localhost:9200/series/_search?pretty' -d '
{
"query" : {
        "has_child":{
          "type":"film",
          "query":{
              "match":{
                "title":"The Force Awakens"
              }
          }
        }
  }
}'
```
