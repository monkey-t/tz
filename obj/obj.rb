require 'selenium-webdriver'

class Test

  def initialize (driver)
    @driver = driver
    @driver.manage.window.maximize
    @wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver.manage.timeouts.implicit_wait = 10
    @driver.manage.timeouts.page_load = 15
    @driver.manage.timeouts.script_timeout = 5
  end

  def element(how, what)
    begin
      el = @driver.find_element(how, what)
      if block_given?
        yield(el)
      else
        el
      end
    rescue
      nil
    end
  end

  @first_url = "http://qa-web-test-task.s3-website.eu-central-1.amazonaws.com/"

  def start_test
    @first_url.click
  end

  @next_url = @first_url + "#{@number}.html"
  @number = 1



  #last_text = @driver.find_element(:tag_name, "h2").match(/*последняя*/)


  def next_page_link
    element(:xpath, "html/body/a").enabled?
  end

  def openPage
    @driver.get @first_url
  end

  def currentUrl
    @driver.current_url
  end

  while next_page_element do
    @next_url
    @number = @number + 1
  end

  if next_page_element
    @next_url
  else
    puts currentUrl
  end

end
