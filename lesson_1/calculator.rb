def say(msg)
  puts "-----#{msg}----"
end

loop do
  say("Enter the first number")
  num1 = gets.chomp

  say("Enter the second number")
  num2 = gets.chomp

  say("1) add 2) subtract 3) multiply 4) divide")
  operator = gets.chomp

  if operator == '1'
    result = num1.to_i + num2.to_i
  elsif operator == '2'
    result = num1.to_i - num2.to_i
  elsif operator == '3'
    result = num1.to_i * num2.to_i
  elsif operator == '4'
    result = num1.to_i / num2.to_i
  end

  say("The answer is #{result}")

  say("Continue using calculator? y/n")
  answer = gets.chomp

  if answer == 'y'
    next
  elsif answer == 'n'
    break
  end
      
end