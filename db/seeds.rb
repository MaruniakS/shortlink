# Generating urls
10000.times do |i|
  Url.create(long: "http://google.com?i=#{i}")
end
