month_hash = {
  "Январь" => 31,
  "Феварль" => 28,
  "Март" => 31,
  "Апрель" => 30,
  "Май" => 31,
  "Июнь" => 30,
  "Июль" => 31,
  "Август" => 31,
  "Сентябрь" => 30,
  "Октябрь" => 31,
  "Ноябрь" => 30,
  "Декабрь" => 31,
}
month_hash.each do |month, count_day|
  puts month if count_day == 30
end
