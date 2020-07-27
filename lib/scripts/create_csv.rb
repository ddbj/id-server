# id, accession, agent, version, status, visibility created_at, updated_at, deleted_at
#
require 'csv'

PREFIX = "AR"

CSV.open('../csv/accession_file2.csv', 'w') do |csv|

  csv << ["accession", "agent", "version", "status", "visibility", "created_at", "updated_at"]
  # 1000万
  10000000.times do |num|
    #p num
    num = num + 10000000
    accession = PREFIX + format('%08d', num)
    if num.even?
      status = "Public"
    else
      status = "Private"
    end
    time = (Time.now + Random.rand(0.1).round(3)).strftime("%Y-%m-%d %H:%M:%S")
    csv << [accession, "ddbj", "0.0.1", status, true, time, time]
  end
end
