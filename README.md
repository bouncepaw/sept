# SEPT HTML (WIP)
S-Expression Powered Template HyperText Markup Language.

## How to use it?
1. Install `sept`. For now, copy some files from this repo and make your own magic. Gem coming soon.
2. Learn syntax by one example.
```lisp
(html
  (head
    (title "Hello world")
    (style ".class { color: blue }"))
  (body
    ("p class='class'" "Note that if a tag has attributes, they are expressed this way")
    (p Cool?)
    (p "This is #{param}")))
```
3. Create some `.sept` files. Then run `ruby path/to/sept.rb file1.sept file2.sept`. `.html` will be generated in the same directory.

Of course, you can run Sept directly from Ruby programs. `Sept.cook("file.sept")` is what you need. Don't forget to require `Sept` module. For better understanding of this program, you can read contents of `sept.rb`.

## Coming soon
I don't promise anything, but I want to implement following:
- Gem (so you can use it very easily)
- Support of this notation: `tag.class1.class2#id otherAttribute=''`
- S-Expression CSS

## Contributing
Fork -> commit -> pull request
