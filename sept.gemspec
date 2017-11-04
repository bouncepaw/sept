Gem::Specification.new do |s|
  s.name        = 'sept'
  s.version     = '1.2.2'
  s.date        = '2017-10-04'
  s.summary     = 'HTML templates as S-Expressions'
  s.description =
    "Write your HTML pages like Lisp code. Support of included files, \
    parameters. CLI utility provided."
  s.authors     = ['Timur Ismagilov']
  s.email       = 'bouncepaw2@ya.ru'
  s.files       = ['lib/sept.rb']
  s.executables << 'sept'
  s.homepage    = 'https://github.com/bouncepaw/sept'
  s.license     = 'MIT'
end
