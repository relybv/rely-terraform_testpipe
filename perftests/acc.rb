require 'selenium-webdriver'
require 'rspec/expectations'
include RSpec::Matchers


driver = Selenium::WebDriver.for :chrome

driver.get 'PERFTARGET'
driver.page_source.include? 'The quick brown fox'
driver.save_screenshot 'loadbalancer.png'
puts "Page title is #{driver.title}"

driver.get 'GRAFANATARGET/login'
expect(driver.title).to eql 'Grafana'
driver.save_screenshot 'grafana_start.png'
driver.find_element(:name, "username").send_keys("admin")
driver.find_element(:name, "password").send_keys("admin")
driver.action.send_keys("\n").perform
sleep 5
driver.save_screenshot 'grafana_login.png'
puts "Page title is #{driver.title}"
driver.get 'GRAFANATARGET/dashboard/db/haproxy-metrics?refresh=5s&orgId=1&from=now-5m&to=now'
sleep 5
driver.save_screenshot 'grafana_haproxy.png'
driver.get 'GRAFANATARGET//dashboard/db/apache-overview?refresh=30s&orgId=1&from=now-5m&to=now'
sleep 5
driver.save_screenshot 'grafana_apache.png'

driver.get 'KIBANATARGET'
# expect(driver.title).to eql 'Kibana'
driver.save_screenshot 'kibana.png'
puts "Page title is #{driver.title}"

driver.get 'RUNDECKTARGET'
# expect(driver.title).to eql 'Rundeck'
driver.save_screenshot 'rundeck.png'
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
