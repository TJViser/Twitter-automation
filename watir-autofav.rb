require 'nokogiri'
require 'watir'
require 'csv'
require 'open-uri'
require 'json'
require 'watir-scroll'
require 'pry-byebug'

browser = Watir::Browser.new

# Put your search Url inside the quotes
browser.goto ""
# Choper les <b> dans la span class 'u-dir'

# CONNEXION

# Put your Username inside the quotes
browser.text_field(:class => 'email-input').set ''
# sleep(1)
# browser.text_field(:type => 'password').set 'toto'

# Put your Password inside the quotes
browser.text_field(:type => 'password').set ''
# sleep(1)
# browser.button(:type =>"submit").click
browser.form(class: "LoginForm").submit

sleep(3)

# 100.times do |i|

#   #
#  browser.scroll.to :bottom
#  sleep(2)
# end

# buttons = browser.buttons(:class => 'ProfileTweet-action--favorite')
# i=0
# buttons.each do |button|
#   if i<2
#     browser.scroll.to [button.wd.location.x, button.wd.location.y]
#     button.click
#   end
#   i+=1
# end


# Replace 100 by the wanted amount of time you want to go down
100.times do |i|

  #
 browser.scroll.to :bottom
 sleep(2)
end

# doc = Nokogiri::HTML.parse(browser.html)
# favorites = doc.search(".ProfileTweet-action--favorite")
favorites = browser.divs(class: "ProfileTweet-action--favorite")
# favorites.uniq!
# binding.pry
favorites.each do |favorite|
  sleep 0.5
  # binding.pry
  # browser.scroll.to [favorite.wd.location.x, favorite.wd.location.y + 100]
  # favorite.click
  if favorite.text == "J'aime"
    puts "nouveau j'aime "
    browser.driver.action.move_to(favorite.wd, 10, 10).click.perform
  else
    puts "jaime déjà"
  end
end



