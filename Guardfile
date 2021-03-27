# frozen_string_literal: true

guard 'bundler' do
  watch('Gemfile')
end

guard 'rack', port: 4567 do
  watch('Gemfile.lock')
  watch(%r{^(config|app|api|lib)/.*})
end

guard :rubocop, cli: ['--auto-correct-all'] do
  watch(/.+\.rb$/)
  watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
end
