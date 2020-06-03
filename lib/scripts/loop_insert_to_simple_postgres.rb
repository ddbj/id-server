require "bundler/setup"

require 'benchmark'
require 'pg'

number = 1000000;
accessions = Array.new
number.times do |i|
  accessions << 'AR' + format('%08d', i)
end

connection = PG::connect(:host => "localhost", :user => "postgres", :password => "postgres", :dbname => "ddbj", :port => "15432")

# insert
insert_result = Benchmark.realtime do
  number.times {|i|
    result = connection.exec(
        "INSERT INTO prefix_ar_10 (accession, agent, version, status, visibility, created_at, updated_at) VALUES ('#{accessions[i]}', 'ddbj', '0.0.1', 'Public', true, now(), now());"
    )
  }
end
puts "insert time of #{number} : #{insert_result.to_s}"

# create index on id
index_result = Benchmark.realtime do
  result = connection.exec(
      "CREATE INDEX prefix_ar_10_id_index ON prefix_ar_10(id);"
  )
end
puts "create index time of #{number} : #{index_result.to_s}"

# select
select_result = Benchmark.realtime do
  number.times {|i|
    result = connection.exec(
      "SELECT * FROM  prefix_ar_10 WHERE accession = '#{accessions[i]}';"
    )
  }
end
puts "select time of #{number} : #{select_result.to_s}"

# update
update_result = Benchmark.realtime do
  number.times {|i|
    result = connection.exec(
        "UPDATE prefix_ar_10 SET version='0.0.2' WHERE  accession = '#{accessions[i]}';"
    )
  }
end
puts "update time of #{number} : #{update_result.to_s}"
