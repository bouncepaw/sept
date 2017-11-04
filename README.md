# SEPT HTML (WIP)
[![Gem Version](https://badge.fury.io/rb/sept.svg)](https://badge.fury.io/rb/sept)
S-Expression Powered Template HyperText Markup Language.

## How to use it?
Run:
```sh
gem install sept
```

Make a `.sept` file:
```lisp
(html
  (head
    (title "Hello world")
    (style ".class { color: blue }"))
  (body
    ("p class='class'" "Note that if a tag has attributes, they are expressed this way")
    (p Cool?)
    (p "This is %{param}")))
```

In the directory where the file is, run:
```sh
sept -d {:param=>"Parameter"} file.sept
```

`file.html` will be generated.

## CLI arguments
There are several arguments you can pass.
- `-h`: displays help
  `sept -h`
- `-v`: displays version
  `sept -v`
- `-d`: you can pass data for parameters, like in example above
  `sept -d {:this_is=>"ruby hash"} file1 file2...`
- `-f`: same like argument above, but hash is stored in file
  `sept -f hashfile file1 file2...`

## TODOs:
I don't promise anything, but I want to implement following:
- [x] Parametets
- [ ] #include directive (WIP)
- [x] Gem
- [ ] Support of this notation: `tag.class1.class2#id otherAttribute=''`
- [ ] S-Expression CSS

## Contributing
Please report all the bugs!
Fork -> commit -> pull request

