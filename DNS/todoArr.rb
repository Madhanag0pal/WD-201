todos = [
  ["Send invoice", "money"],
  ["Clean room", "organize"],
  ["Pay rent", "money"],
  ["Arrange books", "organize"],
  ["Pay taxes", "money"],
  ["Buy groceries", "food"],
]

p todos.group_by { |x, y| y }.map { |k, c| [k, c.map { |t| t[0] }] }

ans1 = todos.each_with_object([]) { |todo, ans|
  x = ans.assoc(todo[1])
  if x
    x[1] << todo[0]
  else
    ans << [todo[1], [todo[0]]]
  end
}
p ans1
