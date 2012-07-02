module ApplicationHelper
	def full_title(page_title)
		base_title = "My practise app"
		if page_title.empty?
			full_title = base_title
		else
			full_title = "#{base_title} | #{page_title}"
		end
	end
end
