# frozen_string_literal: true

desc 'Test docker images'
task :test do
  puts '*** Testing images ***'.green
  $images.each do |image|
    puts "Running tests on #{image.base_tag}"
    container = `docker run --rm --user=$UID -d #{image.base_tag}`.strip
    begin
      sh "/bin/sh -c \"echo hello from #{image.base_tag}\""
      sh "docker exec #{container} nc -vz localhost 1025"
      sh "docker exec #{container} nc -vz localhost 8025"
    ensure
      sh "docker kill #{container}"
    end
  end
end
