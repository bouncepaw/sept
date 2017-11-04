Gem::Specification.new do |s|
  s.name        = 'sept'
  s.version     = '1.3.0'
  s.date        = '2017-10-04'
  s.summary     = 'HTML templates as S-Expressions'
  s.description = <<-DESC
    Write your HTML pages like Lisp code. Support of included files,
    parameters. CLI utility provided.

    Example:
    ```
    (html
      (head
        (title "Hello world")
        (style ".class { color: blue }"))
      (body
        ("p class='class'" "Note that if a tag has attributes, they are expressed this way")
        (p Cool?)
        (p "This is %{param}")))
    ```

		Then run:
		```
		sept -d '{:param=>"Parameter"}' file.sept
		```
  DESC
  s.authors     = ['Timur Ismagilov']
  s.email       = 'bouncepaw2@ya.ru'
  s.files       = ['lib/sept.rb']
  s.executables << 'sept'
  s.homepage    = 'https://github.com/bouncepaw/sept'
  s.license     = 'MIT'
end
