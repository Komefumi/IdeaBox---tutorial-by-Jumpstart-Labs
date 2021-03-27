guard "bundler" do
  watch('Gemfile')
end

guard "rack", :port => 4567 do
  watch("Gemfile.lock")
  watch(%r{^(config|app|api)/.*})
end
