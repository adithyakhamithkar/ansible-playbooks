# Exercise
Download a movielens collection
```
wget http://files.grouplens.org/datasets/movielens/ml-latest-small.zip
```
Create a mapping using the below json in movies-mapping.json

```
{
  "mappings": {
    "movie": {
      "_all": {
        "enabled": false
      },
      "properties": {
        "id": {
          "type": "integer"
        },
        "year": {
          "type": "date"
        },
        "genre": {
          "type": "text",
          "index": false
        },
        "title": {
          "type": "text",
          "analyzer": "english"
        }
      }
    }
  }
}
```
Import the mapping
```
curl -XPUT -H 'Content-Type: application/json' localhost:9200/movies --data-binary @movies-mapping.json
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
curl -XPOST -H 'Content-Type: application/json' 'http://localhost:9200/movies/_bulk' --data-binary @movies.json
```
Update an existing document
```
curl -XPOST -H 'Content-Type: application/json' localhost:9200/movies/movie/109487/_update -d '
{
  "doc":{
    "title":"Intersteller 2"
  }
}
'
```
Delete a document
```
curl -XDELETE -H 'Content-Type: application/json' localhost:9200/movies/movie/109487
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
curl -XPUT -H 'Content-Type: application/json' http://localhost:9200/series --data-binary @series-matching.json
```
Import build from wget http://media.sundog-soft.com/es/series.json
```
curl -XPOST -H 'Content-Type: application/json' 'localhost:9200/movies/_bulk' --data-binary @series.json
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
Using phrase search
```
curl -H 'Content-Type: application/json' -XGET 'localhost:9200/movies/movie/_search?pretty' -d '
{
"query" : {
            "match_phrase":{
              "title":{"query":"star beyond", "slop":100}
            }
  }
}'
```
Using boolean conditions
```
curl -H 'Content-Type: application/json' -XGET 'localhost:9200/movies/movie/_search?pretty' -d '
{
"query" : {
            "bool":{
              "must":{"term":{"title":"trek"}},
              "filter":{"range":{"year":{"gte":2010}}}
            }
  }
}'
```
Combination query
```
curl -H 'Content-Type: application/json' -XGET 'localhost:9200/movies/movie/_search?pretty' -d '
{
"query" : {
            "bool":{
              "must":{"match_phrase":{"title":"Star Wars"}},
              "filter":{"range":{"year":{"gte":2010}}}
            }
  }
}'
```

Pagination (search starts from 0)
Gives first 2 results
```
curl -H 'Content-Type: application/json' -XGET 'localhost:9200/movies/movie/_search?size=2&pretty'
```
Gives the results after first 2 and will displace only the next 2 results
```
curl -H 'Content-Type: application/json' -XGET 'localhost:9200/movies/movie/_search?pretty' -d '
{
"from":2,
"size":2,
"query" : {"match":{"genre":"Sci-Fi"}}
  }
}'
```

Sorting
You can't sort based on text else you will have to reindex the data
```
curl -H 'Content-Type: application/json' -XGET 'localhost:9200/movies/movie/_search?sort=year&pretty'
```

New mapping to sort texts
```
{
  "mappings": {
    "movie": {
      "_all": {
        "enabled": false
      },
      "properties": {
        "id": {
          "type": "integer"
        },
        "year": {
          "type": "date"
        },
        "genre": {
          "type": "text",
          "index": false
        },
        "title": {
          "type": "text",
          "fields": {
            "raw": {
              "type": "text",
              "index": false
            }
          }
        }
      }
    }
  }
}
```
Query to get the sorted version of title
```
curl -H 'Content-Type: application/json' -XGET 'localhost:9200/movies/movie/_search?sort=title.raw&pretty'
```

More on filters
```
curl -H 'Content-Type: application/json' -XGET 'localhost:9200/movies/movie/_search?pretty' -d '
{
"query" : {
            "bool":{
              "must":{"match":{"genre":"Sci-Fi"}},
              "must_not":{"match":{"title":"trek"}},
              "filter":{"range":{"year":{"gte":2010,"lt":2015}}}
            }
  }
}'
```

Fuzziness
```
curl -H 'Content-Type: application/json' -XGET 'localhost:9200/movies/movie/_search?pretty' -d '
{
"query" : {
            "fuzzy":{
              "title":{"value":"intrsteller", "fuzziness":2}
            }
  }
}'
```

Prefix works only on un analyzed
```
curl -H 'Content-Type: application/json' -XGET 'localhost:9200/movies/movie/_search?pretty' -d '
{
"query" : {
            "prefix":{
              "title.raw":"Sta"
            }
  }
}'
```
Wildcard works only on un analyzed
```
curl -H 'Content-Type: application/json' -XGET 'localhost:9200/movies/movie/_search?pretty' -d '
{
"query" : {
            "wildcard":{
              "title.raw":"S*"
            }
  }
}'
```
# Importing data from MySql

```
mysql> create database movielens;
Query OK, 1 row affected (0.00 sec)

mysql> use movielens;
Database changed
mysql> create table movielens.movies;
ERROR 1113 (42000): A table must have at least 1 column
mysql> create table movielens.movies (
    -> movieID INT PRIMARY KEY NOT NULL,
    -> title TEXT,
    -> releaseDate DATE
    -> );
Query OK, 0 rows affected (0.00 sec)

mysql> LOAD DATA LOCAL INFILE 'ml-100k/u.item' INTO TABLE movielens.movies FIELDS TERMINATED BY '|'
    -> (movieID, title, @var3)
    -> set releaseDate = STR_TO_DATE(@var3, '%d-%M-%Y');
```

Download the 100k data

```
wget http://files.grouplens.org/datasets/movielens/ml-100k.zip
```

Install logstash

```
apt-get install logstash
```

Download the mysql jdbc connector
Logstash configure mysql.conf

```
input {
        jdbc {
                jdbc_connection_text => "jdbc:mysql://localhost:3306/movielens"
                jdbc_user => "user"
                jdbc_password => "password"
                jdbc_driver_library => "/home/vagrant/mysql-connector-java-5.1.45/mysql-connector-java-5.1.45-bin.jar"
                jdbc_driver_class => "com.mysql.jdbc.Driver"
                statement => "SELECT * from movielens.movies"
        }
}

output {
        elasticsearch {
                "hosts" => "localhost:9200"
                "index" => "movielens_sql"
                "document_type" => "movielens"
        }
}
```
