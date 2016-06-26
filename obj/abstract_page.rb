require 'selenium-webdriver'
require 'mail'

class AbstractPage

  def initialize (driver)
    @driver = driver
    @driver.manage.window.maximize
    @wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver.manage.timeouts.implicit_wait = 10
    @driver.manage.timeouts.page_load = 15
    @driver.manage.timeouts.script_timeout = 5
  end

  def title
    @driver.title
  end

  def first_url

  end



  def currentUrl
    @driver.current_url
  end

  def openPage
    @driver.get "http://#{Url}"
    self
  end
  
  def navigateToLoginForm
    find_element(:xpath, ".//*[@id='user']/div[1]/div[1]").click
    self
  end

  def navigateToRegForm
    find_element(:xpath, ".//*[@id='user']/div[1]/div[3]").click
  end


  def emailLoginInput
    find_element(:id, "emailLoginInput")
  end

  def pswLoginInput
    find_element(:id, "pswLoginInput")
  end

  def loginButton
    find_element(:id, "loginButton")
  end

  def clear_login (email, pass)
    emailLoginInput.send_keys email
    pswLoginInput.send_keys pass
    loginButton.click
    self
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

  def formName
    find_element(:xpath, ".//*[@class='modal-header']/h3").text
  end

  def delUser
    @driver.get "http://#{Url}del_user"
  end

  def getMailLink
    email = Mail.last.body.decoded
    link = email.match(/http:\/\/#{Url}\mail_link/)
    @driver.get link
  end

  def quit
    @driver.quit
  end
end
