require "bundler/setup"

require 'benchmark'
require 'pg'

number = 1000000;
accessions = Array.new
number.times do |i|
  accessions << 'AR' + format('%08d', i)
end

connection = PG::connect(:host => "localhost", :user => "postgres", :password => "postgres", :dbname => "ddbj", :port => "25432")

=begin
# insert
insert_result = Benchmark.realtime do
  number.times {|i|
    result = connection.exec(
        "INSERT INTO prefix_ar_10 (accession, agent, version, status, visibility, created_at, updated_at) VALUES ('#{accessions[i]}', 'ddbj', '0.0.1', 'Public', true, now(), now());"
    )
  }
end
puts "insert time of #{number} : #{insert_result.to_s}"
=end

# select by id
select_result = Benchmark.realtime do
  number.times {|i|
    result = connection.exec(
        "SELECT * FROM  prefix_ar_10 WHERE id = '#{i}';"
    )
  }
end
puts "select by id time of #{number} : #{select_result.to_s}"

=begin
# select by accession
select_result = Benchmark.realtime do
  number.times {|i|
    result = connection.exec(
        "SELECT * FROM  prefix_ar_10 WHERE accession = '#{accessions[i]}';"
    )
  }
end
puts "select by accession time of #{number} : #{select_result.to_s}"
=end