%w(sxp colorize).each { |f| require f }

# Markup as it should have been
# Write your page as s-expression structure
# (html
#   (head
#     (title Hello World demo))
#   (body
#     (p Hello Wrold!)
#     ("p class='para'" Attributes are also supported in this form)
#     (table
#       (tr
#         (th What)
#         (th Coolness %))
#       (tr
#         (td HTML)
#         (td 0%))
#       (tr
#         (td SEPT)
#         (td %{param})))))
class Sept
  def initialize(params, files_to_parse)
    @params = params
    @html = ''

    files_to_parse.each { |f| self.cook f }
  end


  # Function that 'cooks' passed file. It logs some info. The name is bad
  def cook(filename)
    unless File.extname(filename) == ".sept"
      puts "#{filename} is not `.sept` file, so can't parse it!".red
      return
    end
    @html = ''

    file = File.read filename
    puts "got #{filename}, its content is:\n#{file}"

    new_filename = filename[0..-6] + ".html"
    new_file = self.to_html(self.to_s(SXP.read(file))) % @params

    # Create file if it does not exist yet
    File.new new_filename, 'w+' unless File.file? new_filename
    File.write new_filename, new_file
    puts "parsed #{filename} and saved in #{new_filename}:\n #{new_file}"
  end

  # Recursive function that turns everything in `node` to a string
  # [:sym, [1, "str"]] => ["sym", ["1", "str"]]
  def to_s(node)
    node.each_with_index do |sub, i|
      # Is it hacker-ish?
      sub.is_a?(Array) ? self.to_s(sub) : node[i] = sub.to_s
    end
  end

  # Function that turns array to something usable
  def to_html(node)
    if node.is_a? Array
      if node.length == 1 then @html << "<#{node[0]}/>"
      else
        @html << "<#{node[0]}>"
        node[1..-1].each { |e| self.to_html e }
        @html << "</#{node[0].split(' ')[0]}>"
      end
    else @html << node
    end

    @html
  end
end

ARGV.length == 0 ? puts("Too few arguments".red) : case ARGV[0]
when "-h" # help
  puts 'S-Expression Powered Template HyperText Markup Language',
    'To get version, run `sept -v`',
    'To pass some data, run `sept -d <data> files...`',
    '<data> is a ruby hash ({:key => "value",})',
    'To pass some data via file, run `sept -f <datafile> files...`',
    '<datafile> is a file with ruby hash',
    'Be careful! Any ruby code can be passed along with hash,',
    'validation coming soon'
when "-v" # version
  puts "SEPT HTML version 1.1.1"
when "-d" # data
  puts "Passed data as argument"
  sept = Sept.new(eval(ARGV[1]), ARGV[2..-1])
when '-f' # file
  puts "Passed data as file"
  sept = Sept.new(eval(File.read ARGV[1]), ARGV[2..-1])
else
  puts "No passed data"
  sept = Sept.new({}, ARGV)
end
