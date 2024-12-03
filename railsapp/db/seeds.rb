# This will only run if there's no data in the years table.
unless Year.exists?
  (1..10).each do |id|
    year = 2024 + id
    target_year = id == 1 ? 1 : 0
    Year.create!(id: id, year: year, target_year: target_year)
  end
end

