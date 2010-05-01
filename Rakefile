require 'rubygems'
require 'rake'

$LOAD_PATH.unshift 'lib/'
require 'tophat/version'

begin
  require 'jeweler'
  
  Jeweler::Tasks.new do |gem|
    gem.name = "tophat"
    gem.summary = %Q{TODO: simple view helpers for your layouts}
    gem.description = %Q{TODO: simple view helpers for your layouts}
    gem.email = "steve.agalloco@gmail.com"
    gem.homepage = "http://github.com/spagalloco/tophat"
    gem.authors = ["Steve Agalloco"]
    gem.add_dependency "actionpack", ">= 2.3.5"
    gem.add_development_dependency "shoulda", ">= 0"
    gem.version = TopHat::VERSION
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = TopHat::VERSION

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "tophat #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
