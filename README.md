# SEPT (WIP)
[![Version](https://badge.fury.io/rb/sept.svg)](https://badge.fury.io/rb/sept)
Gem that supports parsing of SeptHTML — HTML template language written as
S-expressions, so code looks like Lisp code. At first, it look strangely, but
once you get used to it, you start to like it.

## Installation
```sh
gem install sept
```

## Creating SeptHTML files
Make a `.septh` file:
```lisp
(html
  (head
    (title "Hello world")
    (style ".red { color: blue }"))
  (body
    (p.red "Check out this cool CSS notation!")
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
- [ ] SeptCSS (`.septc` extension)

## Contributing
Please report all the bugs!
Fork -> commit -> pull request

