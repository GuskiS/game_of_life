require "rake/testtask"

Rake::TestTask.new do |t|
  t.warning = true
  t.verbose = true
  t.test_files = FileList["test/test_helper.rb", "test/*_test.rb"]
end