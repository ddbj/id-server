require "bundler/setup"

require 'benchmark'
require 'pg'

number = 1000;

insert_sql = ""
select_sql = ""
update_sql = ""
number.times do |i|
  accession = 'AR' + format('%08d', i)
  insert_sql += "INSERT INTO prefix_ar_10 (accession, agent, version, status, visibility, created_at, updated_at) VALUES ('#{accession}', 'ddbj', '0.0.1', 'Public', true, now(), now());"
  select_sql += "SELECT * FROM  prefix_ar_10 WHERE accession = '#{accession}';"
  update_sql += "UPDATE prefix_ar_10 SET version='0.0.2' WHERE  accession = '#{accession}';"
end


connection = PG::connect(:host => "localhost", :user => "postgres", :password => "postgres", :dbname => "ddbj", :port => "15432")

# create index on accession
index_result = Benchmark.realtime do
  connection.exec(
      "CREATE INDEX prefix_ar_10_id_index ON prefix_ar_10(id);"
  )
end
puts "create index time of #{number} : #{index_result.to_s}"


# insert
insert_result = Benchmark.realtime do
   result = connection.exec(insert_sql)
end
puts "insert time of #{number} : #{insert_result.to_s}"

# select
select_result = Benchmark.realtime do
  connection.exec(select_sql)
end
puts "select time of #{number} : #{select_result.to_s}"

# update
update_result = Benchmark.realtime do
  connection.exec(update_sql)
end
puts "update time of #{number} : #{update_result.to_s}"
