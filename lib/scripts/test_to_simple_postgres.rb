require "bundler/setup"

require 'benchmark'
require 'pg'

number = 1000;
accessions = Array.new

number.times do |i|
  accessions << 'AR' + format('%08d', i)
end

sql = ""
number.times do |i|
  accession = 'AR' + format('%08d', i)
  sql += "INSERT INTO prefix_ar_10 (accession, agent, version, status, visibility, created_at, updated_at) VALUES ('#{accession}', 'ddbj', '0.0.1', 'Public', true, now(), now());"
end


connection = PG::connect(:host => "localhost", :user => "postgres", :password => "postgres", :dbname => "ddbj", :port => "15432")

# insert
#=begin
insert_result = Benchmark.realtime do
  number.times {|i|
    result = connection.exec(
        "INSERT INTO prefix_ar_10 (accession, agent, version, status, visibility, created_at, updated_at) VALUES ('#{accessions[i]}', 'ddbj', '0.0.1', 'Public', true, now(), now());"
    )
  }
end
puts "insert time of #{number} : #{insert_result.to_s}"
#=end

#insert_result = Benchmark.realtime do
#  result = connection.exec(sql)
#end
#puts "insert time of #{number} : #{insert_result.to_s}"