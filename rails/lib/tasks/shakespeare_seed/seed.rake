

task seed_shake_shingle: :env do
  path = "#{Rails.root}/lib/tasks/shakespear_seed/seed.json"
  index = "shakes_shingles"

  system "curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/#{index}/doc/_bulk?pretty' --data-binary path"
end