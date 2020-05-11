# id, accession, agent, version, status, visibility created_at, updated_at, deleted_at
#
require 'csv'

PREFIX = "AA"

CSV.open('../csv/accession_file.csv', 'w') do |csv|

  csv << ["management_id", "accession", "agent", "version", "status", "visivility", "created_at", "updated_at", "published_at", "deleted_at"]
  # 十万
  100000.times do |num|
    accession = PREFIX + format('%08d', num)
    csv << [1, accession, "ddbj", "0.0.1", "Public", true]
  end
end