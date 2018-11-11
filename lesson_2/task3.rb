fibonacci_arr=[1,1]
while fibonacci_arr[-1]+fibonacci_arr[-2]<100
  fibonacci_arr.push (fibonacci_arr[-1]+fibonacci_arr[-2])
end
puts fibonacci_arr
