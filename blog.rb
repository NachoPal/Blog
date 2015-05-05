require 'date'


class Blog

	attr_accessor :pages
	attr_accessor :num_per_page
	attr_accessor :list_size

	def initialize(num_per_page)
		@post_list = []
		@num_per_page = num_per_page
		@pages = 0 
	end

	def push post
		@post_list << post
	end

	def create_front_page
		@post_list_sorted = @post_list.sort_by {|post| post.date}
		@list_size = @post_list_sorted.size	
	end

	def publish_front_page(index)
		@post_list_sorted = @post_list_sorted[index, @num_per_page]
		@post_list_sorted.each do |post|
			if post.sponsored == false
				puts "#{post.title}\n**************\n#{post.text}\n----------------"
			else
				puts "*******#{post.title}*********\n**************\n#{post.text}\n----------------"
			end	
		end
		pagination
	end

	def pagination
		i = 0
		@pages = @list_size / @num_per_page

		while i < @pages  do
   			print("#{i} " )
   			i +=1
		end

		print "\n"
	end
end

class Post

	attr_accessor :title
	attr_accessor :date
	attr_accessor :text
	attr_accessor :sponsored

	def initialize(title, date, text, sponsored)
		@title = title
		@date = date
		@text = text
		@sponsored = sponsored
	end
end


blog = Blog.new(3)
blog.push Post.new("Uno", Date.new(2015,6,4), "texto1", true)
blog.push Post.new("Dos", Date.new(2015,6,3), "texto2", false)
blog.push Post.new("Tres", Date.new(2014,6,4), "texto3", false)

blog.push Post.new("Cuatro", Date.new(2015,1,4), "texto4", true)
blog.push Post.new("Cinco", Date.new(2012,6,3), "texto5", false)
blog.push Post.new("Seis", Date.new(2013,6,4), "texto6", false)

blog.create_front_page

pag_num = 0;

blog.publish_front_page(pag_num)

while ((pag_num >= 0) && (pag_num <= blog.list_size - blog.num_per_page)) do

    arrow = gets.chomp
    puts pag_num
	if arrow == "r"
		pag_num = pag_num + blog.pages + 1
		blog.create_front_page
		blog.publish_front_page(pag_num)

	elsif arrow == "l"

		pag_num = pag_num - blog.pages - 1
		blog.create_front_page
		blog.publish_front_page(pag_num)
	end
end












