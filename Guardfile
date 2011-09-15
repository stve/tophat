guard 'rspec', :cli => '--format documentation' do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/(.+)\.rb})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^lib/tophat/(.+)\.rb})     { |m| "spec/lib/#{m[1]}_helper_spec.rb" }
  watch('spec/spec_helper.rb') { "spec" }
end
