require "bundler/setup"

require 'benchmark'
require 'pg'

connection = PG::connect(:host => "localhost", :user => "postgres", :password => "postgres", :dbname => "ddbj", :port => "15432")

result = Benchmark.realtime do
  1000.times {|i|
    accession = format('%08d', i)
    result = connection.exec(
        "INSERT INTO prefix_ar_10 (accession, agent, version, status, visibility, created_at, updated_at) VALUES (#{accession}, 'ddbj', '0.0.1', 'Public', true, now(), now());"
    )
  }
end
puts result.to_s