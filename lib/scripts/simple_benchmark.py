from benchmarker import Benchmarker
import psycopg2

connection = psycopg2.connect("dbname=ddbj host=localhost user=postgres password=postgres port=15432")

cur = connection.cursor()
loop = 1000

with Benchmarker(loop, width=20) as bench:

    @bench('insert')
    def insert(bm):
        for i in range(loop):
            query = "INSERT INTO prefix_ar_10 (accession, agent, version, status, visibility, created_at, updated_at) VALUES (%s, 'ddbj', '0.0.1', 'Public', true, now(), now())"
            cur.execute(query,  ['AR' + '{:0=8}'.format(i)])


        connection.commit()