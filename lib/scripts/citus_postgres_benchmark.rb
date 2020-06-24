require "bundler/setup"

require 'benchmark'
require 'pg'

connection = PG::connect(:host => "localhost", :user => "postgres", :password => "postgres", :dbname => "ddbj", :port => "25432")

number = 1000000

connection.prepare('insert', "INSERT INTO prefix_ar_10 (accession, agent, version, status, visibility, created_at, updated_at) VALUES ($1, 'ddbj', '0.0.1', 'Public', true, now(), now())")
connection.prepare('select', "SELECT * FROM  prefix_ar_10 WHERE accession = $1")
connection.prepare('update', "UPDATE prefix_ar_10 SET version='0.0.2' WHERE  accession = $1")
connection.prepare('update2', "UPDATE prefix_ar_10 SET version='0.0.3' WHERE  accession = $1")

# insert with transaction
insert_with_transaction_result = Benchmark.realtime do
  connection.exec('BEGIN')
  number.times do |i|
    connection.exec_prepared('insert', ['AR' + format('%08d', i)])
  end
  connection.exec('COMMIT')
end
puts "insert with transaction time of #{number} : #{insert_with_transaction_result.to_s}"

# 一旦テーブルを空にする
connection.exec('TRUNCATE TABLE prefix_ar_10 RESTART IDENTITY;')

# insert without transaction
insert_without_transaction_result = Benchmark.realtime do
  number.times do |i|
    connection.exec_prepared('insert', ['AR' + format('%08d', i)])
  end
end
puts "insert without transaction time of #{number} : #{insert_without_transaction_result.to_s}"

# select with transaction
select_with_transaction_result = Benchmark.realtime do
  connection.exec('BEGIN')
  number.times do |i|
    connection.exec_prepared('select', ['AR' + format('%08d', i)])
  end
  connection.exec('COMMIT')
end
puts "select with transaction_time of #{number} : #{select_with_transaction_result.to_s}"

# select without transaction
select_with_transaction_result = Benchmark.realtime do
  number.times do |i|
    connection.exec_prepared('select', ['AR' + format('%08d', i)])
  end
end
puts "select without transaction_time of #{number} : #{select_with_transaction_result.to_s}"

# update with transaction
update_with_transaction_result = Benchmark.realtime do
  connection.exec('BEGIN')
  number.times do |i|
    connection.exec_prepared('update', ['AR' + format('%08d', i)])
  end
  connection.exec('COMMIT')
end
puts "update with transaction time of #{number} : #{update_with_transaction_result.to_s}"

# update without transaction
update_without_transaction_result = Benchmark.realtime do
  number.times do |i|
    connection.exec_prepared('update2', ['AR' + format('%08d', i)])
  end
end
puts "update without transaction time of #{number} : #{update_without_transaction_result.to_s}"