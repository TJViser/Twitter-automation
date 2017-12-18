require 'nokogiri'
require 'watir'
require 'csv'
require 'open-uri'
require 'json'
require 'watir-scroll'
require 'pry-byebug'

browser = Watir::Browser.new
# Put your Search url inside the quotes
browser.goto ""
# Choper les <b> dans la span class 'u-dir'

# CONNEXION
# Put your Usernam inside the quotes
browser.text_field(:class => 'email-input').set ''
# sleep(1)
# browser.text_field(:type => 'password').set 'toto'
browser.text_field(:type => 'password').set ''
# sleep(1)
# browser.button(:type =>"submit").click
browser.form(class: "LoginForm").submit

sleep(3)

1.times do |i|

  #
 browser.scroll.to :bottom
 sleep(2)
end
# following-text
doc = Nokogiri::HTML.parse(browser.html)
usernames_ = []
usernames = doc.search(".username")
usernames.each do |username|
  usernames_ << username.text[1..-1]
  # browser.scroll.to [username.wd.location.x, username.wd.location.y]
end
# binding.pry
p usernames_.size

usernames_.reject! { |a| a =="" || a=="TJViser" }
usernames_.uniq!

p usernames_.size

csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
CSV.open("save.csv",  'wb', csv_options) do |csv|
  usernames_.each do |username|
    csv << [username]
  end
end

#end of treatment



usernames_.each do |username|
  # p usernames_
  browser.goto "https://www.twitter.com/#{username}"
  sleep(1)
  if !browser.div(class: "following").exists?
    browser.button(:type =>"submit").click
    browser.span(:class => 'follow-button').click
    puts "You just followed #{username}"
    sleep(1)
  else
    puts "You already follow #{username}, no action ..."
  end
end





















