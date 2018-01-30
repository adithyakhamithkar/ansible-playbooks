import csv
from collections import deque
import elasticsearch
from elasticsearch import helpers

def readMovies():
    csvfile = open('ml-latest-small/movies.csv', 'r')

    titleLookup = readMovies()

    reader = csv.DictReader( csvfile )
    for line in reader:
        rating = {}
        rating['movie_id'] = int(line['movieId'])
        rating['title'] = titleLookup[line['title']]
        rating['genres'] = titleLookup[line['genres']]
        yield rating


es = elasticsearch.Elasticsearch()

es.indices.delete(index="movies",ignore=404)
deque(helpers.parallel_bulk(es,readMovies(),index="movies",doc_type="movie"), maxlen=0)
es.indices.refresh()
