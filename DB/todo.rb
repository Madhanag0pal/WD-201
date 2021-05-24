require "active_record"
require "date"

class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.add_task(h)
    Todo.create!(todo_text: h[:todo_text], due_date: Date.today + h[:due_in_days], completed: false)
  end

  def self.overdue
    Todo.where("due_date < ?", Date.today)
  end

  def self.due_today
    Todo.where("due_date = ?", Date.today)
  end

  def self.due_later
    Todo.where("due_date > ?", Date.today)
  end

  def self.show_list
    puts "My Todo-list\n\n"

    puts "Overdue\n"
    puts overdue.to_displayable_list
    puts "\n\n"

    puts "Due Today\n"
    puts due_today.to_displayable_list
    puts "\n\n"

    puts "Due Later\n"
    puts due_later.to_displayable_list
    puts "\n\n"
  end

  def self.mark_as_complete!(id)
    todo = find(id)
    todo.completed = !todo.completed
    todo.save!
    todo
  end

  def self.to_displayable_list
    all.map { |todo| todo.to_displayable_string }
  end
end
