%w(sxp colorize json).each { |f| require f }

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

  # Constructor. The only method you would need
  #
  # @param params [Hash] Hash with parameters.
  # @params files_to_parse [Array] List of files program will try to parse
  def initialize(params, files_to_parse)
    @params = params
    @html = ''

    files_to_parse.each { |f| self.cook f }
  end

  # Method that chains lots of methods
  #
  # @param file [String] Sept file
  # @return [String] HTML file
  def generate(file)
    self.to_html self.prepare SXP.read file % @params
  end

  # Function that 'cooks' passed file. It logs some info. The name is bad
  #
  # @param filename [String] Name of file to 'cook'
  def cook(filename)
    @html = ''

    file = File.read filename
    puts "Got #{filename}:\n#{file}"

    filename = filename[0..-5] + 'html'
    file = self.generate file

    # Create file if it does not exist yet
    File.new filename, 'w+' unless File.file? filename
    File.write filename, file
    puts "Parsed and saved in #{filename}:\n#{file}"
  end

  # Recursive function that turns everything in `node` to a string
  #
  # @param node [Array, String] A Sept node
  def self.prepare(node)
    node.each_with_index do |sub, i|
      if sub.is_a? Array
        Sept.prepare sub
      else
        node[i] = sub.to_s
      end
    end
  end

  # Recursive function that generates HTML string and handles `#include`
  #
  # @param node [Array, String] A Sept node
  # @return [String]
  def to_html(node)
    if node.is_a? Array
      if node.length == 1
        @html << "<#{node[0]}/>"
      else
        if node[0] == "#include"
          file = self.generate File.read node[1].to_s
          node = []
          node[0] = file
        else
          temp = Sept.unfold_tag node[0]
          @html << "<#{temp}>"
          node[1..-1].each { |e| self.to_html e }
          @html << "</#{temp.split(' ')[0]}>"
        end
      end
    else
      @html << node
    end

    @html
  end

  # Function that unfolds dot-notation and hash-notation
  # p.class.class-to#id onclick="..."
  # 'p class="class class-too" id="id" onclick="..."'
  # #id must be after .classes
  #
  # @param tag [String] String like `tag.class.class2#id other-arg=""`
  # @return [String] Unfolded tag
  def self.unfold_tag(tag)
    halves = tag.split(' ')
    half = halves[0]

    id = ''
    if half.include? '#'
      temp = half.split('#')
      id = temp[-1]
      half = temp[0..-2].join('')
    end

    klass = ''
    if half.include? '.'
      temp = half.split('.')
      klass = temp[1..-1].join(' ')
      half = temp[0]
    end

    ret = half
    ret << " class='#{klass}'" unless klass.empty?
    ret << " id='#{id}'" unless id.empty?
    ret << " #{halves[1]}" unless halves[1].nil?

    ret
  end
end

