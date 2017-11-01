require 'sxp'
require 'colorize'
require 'pp'

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
#         (td 100%)))))
module Sept

  # Main function
  def Sept.run
    if ARGV.length == 0 then puts 'SEPT:'.red, "Too few arguments"
    elsif ARGV[0] == "-h"
      puts "SEPT HTML".yellow,
        'S-Expression Powered Template HyperText Markup Language'
    else ARGV.each { |f| cook f }
    end
    exit
  end

  # Function that 'cooks' passed file. It logs some info
  def Sept.cook(filename)
    $html = '' # i know this is bad technique, but it solves my problems
    unless File.extname(filename) == ".sept"
      print "SEPT: ".red, "SEPT files must end with `.sept` extension, ",
        "so can't parse `#{filename}`\n"
      return
    end

    file = File.read filename
    print "SEPT: ".yellow, "got #{filename}, its content is:\n"
    pp file

    new_filename = filename[0..-6] + ".html"
    new_file = Sept.parse_params(
      Sept.to_html(Sept.to_s(SXP.read(file))),
      { :param1 => 'This is first param', :param2 => 'And the second' })

    File.new new_filename, "w+" unless File.file? new_filename
    File.write new_filename, new_file
    print "SEPT: ".yellow, "parsed #{filename} and saved in #{new_filename}:\n"
    pp new_file
  end

  # Recursive function that turns everything in `node` to a string
  # This workaround is needed because of how the sxp parser works
  def Sept.to_s(node)
    node.each_with_index do |sub, i|
      case sub
      when Numeric, Symbol then node[i] = sub.to_s
      when Array then Sept.to_s sub
      end
    end
  end

  # Function that turns array to something usable
  def Sept.to_html(node)
    # in a nutshell, sept-expressed tag is like that:
    # ("tagname and attributes" children...)
    # `children` can be either strings or tags

    if node.is_a? Array
      if node.length == 1 then $html << "<#{node[0]}/>"
      else
        $html << "<#{node[0]}>"
        node[1..-1].each { |e| Sept.to_html e }
        $html << "</#{node[0].split(' ')[0]}>"
      end
    else
      $html << node
    end

    $html
  end

  # Recursive function that replaces every `$param` in `node` with
  # corresponding value
  # `regex` is formed like that: `Regex.new('(' + params.keys.join('|') + ')')`
  def Sept.parse_params(page, params)
    # Adding mustaches to param names
    # Is this a workaround, or not? :thinking:
    page % params
  end
end

Sept.run
