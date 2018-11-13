fibonacci_arr = [1, 1]
fibonacci_next = 2
while fibonacci_next < 100
  fibonacci_arr.push(fibonacci_next)
  fibonacci_next = fibonacci_arr[-1] + fibonacci_arr[-2]
end
puts fibonacci_arr
