class TodoItemsController < ApplicationController
	before_action :set_todo_list
	before_action :set_todo_item, except: [:create, :new, :overdue]

	def create
		@todo_list = TodoList.find(params[:todo_list_id])

		@todo_item = @todo_list.todo_items.new(todo_item_params)

=begin
		if @todo_item.duedate.nil? == true
			@todo_item.duedate = Time.now
		end
=end
		@todo_item.save!
		
		if redirect_to @todo_list

		else
			redirect_to @todo_item, notice: "Create a new Todo was not possible"
		end		 

=begin
    @todo_item = todo_list.todo_item.create(todo_item_params)
    	if @todo_list.save
    		format.html { redirect_to @todo_item, notice: 'Todo Item was successfully created.' }
        	format.json { render :show, status: :created, location: @todo_item}
        else
        	redirect_to @todo_item, notice: "Create a new Todo was not possible"
        end
  	end
		
 	

		@todo_item = @todo_list.todo_items.build(todo_item_params)

		if @todo_item.save
			redirect_to @todo_list
		else 
			redirect_to @todo_item, notice: "Create a new Todo was not possible"
		end
=end
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


 	def new
    	@todo_item = current_user.todo_lists.build
    	@todo_item.id = params[:id]
  	end


	def index
	  @todo_item = TodoItem.search(params[:search])
	end



=begin
	def show 
		@search = TodoItem.ransack(params[:search])
		@todo_list_todo_item = @search.result ransack

    	@todo_item = TodoItem.find(params[:id]) Ursprünglich
  	end 

=end	

  	def search
  		index

  		render :show
  	end 


	private

	def set_todo_list
		@todo_list = TodoList.find(params[:todo_list_id])
	end

	def set_todo_item

		@todo_item = @todo_list.todo_items.find(params[:id])

	end


	def todo_item_params
		params[:todo_item].permit(:content, :duedate)
	end
	
=begin
	def todo_item_params
		params[:todo_item]
	end
=end

end

