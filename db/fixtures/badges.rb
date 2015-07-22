Badge.seed do |s|
  s.id = 1
  s.name = '生徒'
  s.color = :bronze
  s.description = '初めての質問'
end

Badge.seed do |s|
  s.id = 2
  s.name = '先生'
  s.color = :bronze
  s.description = '初めての回答'
end

Badge.seed do |s|
  s.id = 101
  s.name = '常連'
  s.color = :silver
  s.description = '質問・回答合わせて10個したことがある'
end
