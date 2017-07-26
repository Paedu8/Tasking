class AddDuedateToTodoitems < ActiveRecord::Migration[5.0]
  def change
    add_column :todo_items, :duedate, :date
  end
end
