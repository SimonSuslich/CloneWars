arr = [1, 2, 3]

result = arr.find do |element|
    element == 1
end.nil? ? "404" : nil

p result