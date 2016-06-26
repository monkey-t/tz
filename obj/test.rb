require 'rubygems'
require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox, marionette: true
driver.get "http://qa-web-test-task.s3-website.eu-central-1.amazonaws.com/"

last_text = driver.find_element(:tag_name, "h2").text
#qwe = last_text.match(/[а-я]последняя[а-я]/)
p last_text