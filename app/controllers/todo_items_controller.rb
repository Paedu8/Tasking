class TodoItemsController < ApplicationController
	before_action :set_todo_list
	before_action :set_todo_item, except: [:create]

	def create
		@todo_item = @todo_list.todo_items.create(todo_item_params)

		if @todo_item.save
			redirect_to @todo_list
		else 
			redirect_to @todo_item, notice: "Create a new Todo was not possible"
		end
	end

	def destroy
		
		if @todo_item.destroy
			flash[:success] = "Todo Item was deleted"
		else 
			flash[:error] = "Todo Item could not be deleted"
		end
		redirect_to @todo_list
	end

	def complete

		if @todo_item.done != true
			@todo_item.update_attribute(:done, true)
			@todo_item.update_attribute(:completed_at, Time.now)
			redirect_to @todo_list, notice: "Todo item completed"
		else 
			@todo_item.update_attribute(:done, false)
			@todo_item.update_attribute(:completed_at, nil)
			redirect_to @todo_list, notice: "Todo item was reopened"
		end 
	end

	def show
    	@todo_item = TodoItem.find(params[:id])
  	end



	private

	def set_todo_list
		@todo_list = TodoList.find(params[:todo_list_id])
	end

	def set_todo_item
		@todo_item = @todo_list.todo_items.find(params[:id])
	end

	def todo_item_params
		params[:todo_item].permit(:content)
	end
end
