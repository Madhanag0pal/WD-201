require "./connect_db.rb"
connect_db!

ActiveRecord::Migration.create_table(table_name.to_sym) do |t|
  t.column :todo_text, :text
  t.column :due_date, :date
  t.column :completed, :bool
end
