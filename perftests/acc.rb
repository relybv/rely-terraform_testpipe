require 'selenium-webdriver'
require 'rspec/expectations'
include RSpec::Matchers


driver = Selenium::WebDriver.for :chrome


driver.get 'https://paars.notarisdossier.nl'
expect(driver.title).to eql 'Let op - Notarisdossier'
driver.save_screenshot 'notarisdosssier.png'
puts "Page title is #{driver.title}"

driver.get "http://google.com"
element = driver.find_element :name => "q"
element.send_keys "Cheese!"
element.submit

puts "Page title is #{driver.title}"

wait = Selenium::WebDriver::Wait.new(:timeout => 10)
wait.until { driver.title.downcase.start_with? "cheese!" }

puts "Page title is #{driver.title}"
driver.quit
