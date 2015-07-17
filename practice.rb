# Find All Anagrams
words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']

answer = {}

words.each do |word, i|
	key = word.split('').sort.join
	if !answer.has_key?(key)
		answer[key] = [word]
	elsif
		answer[key].push(word)
	end
end

answer.each_value do |v|
	p v
end

# ----- Dir -----
d = Dir.new('.') # Current Dir
while file = d.read do
	puts "#{file} has extension .png" if File.extname(file) == ".png"
end

# ----- Pathname -----
require 'pathname'
pn = Pathname.new(".")
pn.entries.each { |f| puts f }
pn.entries.each { |f| puts "#{f} has extension .png" if f.extname == ".png" }


# ----- Open a XML file. Find 'item' elements, and parse them with Nokogiri -----
require 'nokogiri'
slashdot_articles = []
File.open("slashdot.xml", "r") do |f|
  doc = Nokogiri::XML(f)
  slashdot_articles = doc.css('item').map { |i|
    {
		title: i.at_css('title').content,
		link: i.at_css('link').content,
		summary: i.at_css('description').content
    }
  }
end


# ----- Open JSON file. -----
require 'json'
feedzilla_articles = []
File.open("feedzilla.json", "r") do |f|
	items = JSON.parse(f.read.force_encoding('UTF-8'))
	feedzilla_articles = items['articles'].map { |a|
		{
			title: a['title'],
			link: a['url'],
			summary: a['summary']
		}
	}
end

sorted_articles = (feedzilla_articles + slashdot_articles).sort_by { |a| a[:title] }


# ----- export sorted_articles into two different types of file formats ----- 
require 'csv'
CSV.open("articles.csv", "wb") do |csv|
	sorted_articles.each { |a| csv << [a[:title], a[:link], a[:summary]] }
end

require 'axlsx'
pkg = Axlsx::Package.new
pkg.workbook.add_worksheet(:name => "Articles") do |sheet|
	sorted_articles.each { |a| sheet.add_row [a[:title], a[:link], a[:summary]] }
end
pkg.serialize("articles.xlsx")


# ----- Regex -----
def has_b?(string)
	if /b/.match(string)
		puts "We have a 'b'"
	else 
		puts "No match here"
	end
end

has_b?("Basketball")
has_b?("football")
has_b?("hockey")
has_b?("golf")

# ----- Standard Classes -----
# Math
p Math.sqrt(400)
p Math::PI
# Time
t = Time.new(2015, 7, 16)
p t
p t.monday?
p t.thursday?

# ----- Pointer? -----
def test(b)
	b.map { |l| "I like the letter: #{l}" }
end

def test2(b)
	b.map! { |l| "I like the letter: #{l}" }
end

a = ['a', 'b', 'c']
p test(a)
p a
p test2(a)
p a


# ----- Passing block! -----
# '&' tell us the argument is a block
# The block must always be the last parameter in the method definition
def take_block(&block) 
	block.call
end

# we can pass in a block of code using 'do/end'
take_block do 
	puts "Block being called in the method~~~~"
end

def take_block2(number, &block)
	block.call # .call ===> to activate block
end

[1, 2, 3, 4, 5].each do |n|
	take_block2 n do
		puts "Block being called in the method! #{n}"
	end
end


# ----- 'Procs' are blocks that are wrapped in a proc object and stored in a variable to be passed around -----
talk = Proc.new do
	puts "I'm talking."
end

talk.call

talk2 = Proc.new do |name|
	puts "I'm talking to #{name}"
end

talk2.call "Bob"

# more proc
def take_proc(proc)
	[1, 2, 3, 4, 5].each do |num|
		proc.call num
	end
end

proc = Proc.new do |num|
	puts "#{num}. Proc being called in the method!"
end

take_proc(proc)


# ----- Exception Handling -----
names = ['bob', 'joe', 'steve', nil, 'frank']

names.each do |name|
	begin
		puts "#{name}'s name has #{name.length} letters in it."
	rescue
		puts "Something went wrong!"
	end
end

# inline exception example (no each method on an Integer)
zero = 0
puts "Before each call"
zero.each { |element| puts element } rescue puts "Can't do that!"
puts "After each call"

# divide by 0
def divide(number, divisor)
  begin
    answer = number / divisor
  rescue ZeroDivisionError => e
    puts e.message
  end
end

puts divide(4, 0)











