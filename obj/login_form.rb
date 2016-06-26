# coding: utf-8
require_relative '../Obj/abstract_page'

class LoginForm < AbstractPage

  attr_reader :ava
  attr_reader :emailShort
  attr_reader :emailFormat
  attr_reader :pswShort
  attr_reader :wrongPsw

  def initialize (driver)
    super(driver)
  end

  def reset
    @emailShort  = nil
    @emailFormat = nil
    @pswShort    = nil
    @wrongPsw    = nil
    @notConf = nil
    self
  end

  def openRegForm
    element(:class, "user_info_register")
  end

  def terms
    element(:xpath, "html/body/div[2]/div[1]/div/div[3]/a")
  end

  def ava_enabled?
    begin
      element(:class, "name").text
    rescue
      nil
    end
  end

  #алерты
  def emailShort
    element(:id, "emailShort") { |i| i.text }
  end

  def emailFormat
    element(:id, "emailFormat") { |i| i.text }
  end

  def pswShort
    element(:id, "pswShort") { |i| i.text }
  end

  def wrongPsw
    element(:id, "WRONG_PASSWORD") { |i| i.text }
  end

  def notConf
    element(:id, "EMAIL_NOT_CONFIRMED") { |i| i.text }
  end

  def clear
    emailLoginInput.clear
    pswLoginInput.clear
  end

  def login(email, pass)
    clear
    emailLoginInput.click
    clear_login(email, pass)
    loggedIn = begin
      @wait.until { ava_enabled? }
      true
    rescue Selenium::WebDriver::Error::TimeOutError
      false
    end
    if loggedIn
    else
      @emailShort = emailShort
      @emailFormat = emailFormat
      @pswShort = pswShort
      @wrongPsw = wrongPsw
      @notConf = notConf
    end
  end
end