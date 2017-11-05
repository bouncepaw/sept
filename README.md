# SEPT HTML (WIP)
[![Version](https://badge.fury.io/rb/sept.svg)](https://badge.fury.io/rb/sept)

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
    (p.class "Check out this cool CSS notation!")
    (p Cool?)
    (p "This is %{param}")))
```

In the directory where the file is, run:
```sh
sept -d {"param":"Parameter"} file.sept
```

`file.html` will be generated.

Run `sept -h` to get more help.

## TODOs:
- [x] Parameters
- [x] `#include` directive
- [x] Gem
- [x] Support of CSS notation: `tag.class1.class2#id otherAttribute=''`
- [ ] S-Expression CSS

## Contributing
Please report all the bugs!
Fork -> commit -> pull request

