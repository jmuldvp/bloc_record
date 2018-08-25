# Write a method that converts a snake_case string into CamelCase using regular expressions.

def camelcase(sc)
  sc.capitalize!
  sc.gsub!(/_[a-z]/) {|s| s.upcase}
  sc.gsub(/_/, '')
end

snake_case = "here_is_a_snake_case_value_turned_into_camel_case"
p "Original value: #{snake_case}"
p "New value: #{camelcase(snake_case)}"
