# id, accession, agent, version, status, visibility created_at, updated_at, deleted_at
#
require 'csv'

PREFIX = "AR"

CSV.open('../csv/accession_file.csv', 'w') do |csv|

  csv << ["accession", "agent", "version", "status", "visibility", "created_at", "updated_at"]
  # 1000万
  10000000.times do |num|
    accession = PREFIX + format('%08d', num)
    if num.even?
      status = "Public"
    else
      status = "Private"
    end
    csv << [accession, "ddbj", "0.0.1", status, true, Time.now, Time.now]
  end
end