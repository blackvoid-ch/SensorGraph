root_path = File.expand_path(File.expand_path(File.dirname(__FILE__)) + "/../")

worker_processes ENV['UNICORN_WORKERS'].to_i
working_directory root_path

listen "#{root_path}/tmp/sockets/unicorn.sock"

# Abort request if it exceeds 20 seconds
timeout 20

# Reduce memory usage and server costs.
preload_app true

pid "#{root_path}/tmp/pids/unicorn.pid"

if ENV['RAILS_ENV'] == 'production'
  stderr_path "#{root_path}/log/unicorn.stderr.log"
  stdout_path "#{root_path}/log/unicorn.stdout.log"
end

check_client_connection true

before_fork do |server, worker|
  # Terminate any connections to the database.
  ActiveRecord::Base.connection.disconnect!

  # For zero downtime deploys.
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # well, shit. Seems like the process isn't even running.
    end
  end

  # Throttle master from forking too quickly. Partially prevents identical
  # repeated signals from being lost when the receiving process is busy.
  sleep 1
end

after_fork do |server, worker|
  # Re-establish the connection to the database.
  ActiveRecord::Base.establish_connection
end