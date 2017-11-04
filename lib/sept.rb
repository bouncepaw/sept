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
# Learn more at:
# - https://rubygems.org/gems/sept
# - https://github.com/bouncepaw/sept
class Sept

  # Constructor
  #
  # @param params [Hash] Hash with parameters. Keys are symbols, values are strings.
  # @params files_to_parse [Array] List of files program will try to parse
  def initialize(params, files_to_parse)
    @params = params
    @html = ''

    files_to_parse.each { |f| self.cook f }
  end

  # Method that generates ready HTML file from Sept file
  #
  # @param file [String] Sept file
  # @return [String] HTML file
  def generate(file)
    self.to_html(self.prepare(SXP.read(file))) % @params
  end

  # Function that 'cooks' passed file. It logs some info. The name is bad
  #
  # @param filename [String] Name of file to 'cook'
  def cook(filename)
    unless File.extname(filename) == ".sept"
      puts "#{filename} is not `.sept` file, so can't parse it!".red
      return
    end
    @html = ''

    file = File.read filename
    puts "got #{filename}, its content is:\n#{file}"

    new_filename = filename[0..-6] + ".html"
    new_file = self.generate file

    # Create file if it does not exist yet
    File.new new_filename, 'w+' unless File.file? new_filename
    File.write new_filename, new_file
    puts "parsed #{filename} and saved in #{new_filename}:\n #{new_file}"
  end

  # Recursive function that turns everything in `node` to a string and handles
  # including of other files (well, will handle)
  #
  # @param node [Array, String] A Sept node
  def prepare(node)
    node.each_with_index do |sub, i|
      if sub.is_a? Array
        self.prepare sub
      else
        node[i] = sub.to_s
        # TODO: finish this thing
        if node[0] == "#include"
          file = self.generate File.read node[1].to_s
          node.pop until node.length == 0
          node[0] = file
        end
      end
    end
  end

  # Recursive function that generates HTML string.
  #
  # @param node [Array, String] A Sept node
  # @return [String]
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

