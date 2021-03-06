require "date"

class Todo
  def initialize(text, due_date, completed)
    @text, @date, @completed = text, due_date, completed
  end

  #Converts todo to string
  def to_displayable_string
    compleated, date = @completed ? "X" : " ", (@date != Date.today) ? " #{@date}" : ""
    "#{[compleated]} #{@text} #{date}"
  end

  def overdue?
    @date < Date.today
  end

  def due_today?
    @date == Date.today
  end

  def due_later?
    @date > Date.today
  end
end

class TodosList
  def initialize(todos)
    @todos = todos.clone
  end

  def add(todo)
    @todos.push(todo)
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end

  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end

  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end

  def to_displayable_list
    @todos.map { |todo| todo.to_displayable_string }.join("\n")
  end
end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
