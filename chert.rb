t1 = Time.now
sleep(2)
t2 = Time.now

t3 = Time.now
t3 = t2 - t1
puts "#{t3 / 60}"