Gem::Specification.new do |s|
  s.name        = 'sept'
  s.version     = '1.4.2'
  s.date        = '2017-10-08'
  s.summary     = 'HTML templates as S-Expressions'
  s.description = <<-DESC
    Write your HTML pages like Lisp code. CLI utility. Run `sept -h` for info

    (html
      (head
        (title "Hello world")
        (style ".red { color: blue }"))
      (body
        (p.red#cool-and-good "Handy classes and ids. Id must be last")
        ("p onclick='func()'" "Other attributes are expressed that way")
        (p "This is %{param}")))
  DESC
  s.authors     = ['Timur Ismagilov']
  s.email       = 'bouncepaw2@ya.ru'
  s.files       = ['lib/sept.rb']
  s.executables << 'sept'
  s.homepage    = 'https://github.com/bouncepaw/sept'
  s.license     = 'MIT'
end
