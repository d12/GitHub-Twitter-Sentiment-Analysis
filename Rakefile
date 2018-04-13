require 'twitter'
require 'sentimental'
require 'json'

app_path = File.expand_path(File.dirname(__FILE__))
log_file = File.join(app_path, 'logs/tweet_logs.txt')

unless File.exists? log_file
  File.open(log_file, "w") {}
end

task :process_tweets do
  $stdout.reopen(log_file, "a")
  $stderr.reopen(log_file, "a")
  puts "** Beginning Rake task **"
  puts "Initializing client..."
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
    config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
  end

  puts "Grabbing last 10 tweets"
  last_ten_tweets = client.search("github", result_type: "recent", lang: "en").take(10)

  analyzer = Sentimental.new
  analyzer.load_defaults

  puts "Analyzing tweets..."
  scores = last_ten_tweets.map do |tweet|
    {
      body: tweet.text,
      url: tweet.url,
      score: analyzer.score(tweet.text)
    }
  end

  puts "Tweet data:"
  puts JSON.pretty_generate(scores)
end
