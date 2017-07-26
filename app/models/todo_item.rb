class TodoItem < ApplicationRecord
  belongs_to :todo_list

	def completed?
		!completed_at.blank?
	end

	

	def self.search(search)
	  if search
	    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
	  else
	    find(:all)
	  end
	end



end
