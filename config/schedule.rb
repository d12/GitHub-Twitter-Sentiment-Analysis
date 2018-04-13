app_path = File.join(File.expand_path(File.dirname(__FILE__)), "..")
log_file = File.join(app_path, 'logs/cron_logs.txt')

File.open(log_file, "w") {}

every 1.minute do
  command "echo \"running cron job\" && cd #{app_path} && rake process_tweets >> #{log_file} 2>&1"
end
