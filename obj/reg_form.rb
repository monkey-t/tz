# coding: utf-8
require_relative '../Obj/abstract_page'

class Reg_form < AbstractPage

  attr_reader :emailShort
  attr_reader :emailFormat
  attr_reader :passwordShort
  attr_reader :passwordsDiffer


  def initialize (driver)
    super(driver)
  end

  def reset
    @emailShort = nil
    @emailFormat = nil
    @passwordShort = nil
    @passwordsDiffer = nil
    self
  end

  # Step 1
  def emailInput
    @driver.find_element(:id, "emailInput")
  end

  def pswRegister
    @driver.find_element(:id, "pswRegisterInput")
  end

  def pswRepeat
    @driver.find_element(:id, "pswRegisterRepeatInput")
  end

  def createAccBtn
    @driver.find_element(:id, "createAccountButton")
  end

  def is_agent
    @driver.find_element(:id, "is_agent")
  end

  # АЛЕРТЫ
  def emailShort
    find_element(:id, "emailShort") { |i| i.text } #Поле e-mail обязательно к заполнению
  end

  def passwordShort
    find_element(:id, "passwordShort") { |i| i.text } #Пароль должен быть не короче 6 символов
  end

  def emailFormat
    find_element(:id, "emailFormat") { |i| i.text } #Некорректный e-mail
  end

  def passwordsDiffer
    find_element(:id, "passwordsDiffer") { |i| i.text } #Пароли не совпадают
  end

  def confirm_button
    find_element(:xpath, ".//*[@class='confirm-buttons']/button")
  end

  def confirm_header
    begin
      find_element(:xpath, ".//*[@class='modal-dialog']/h3").text #Вы успешно зарегистрировались
    rescue
      nil
    end
  end

  def confirm_message
    find_element(:class, "confirm-message").text #Ссылка для подтверждения регистрации отправлена на указанную почту: test@test.ru \ Для восстановления пароля, пожалуйста, перейдите по ссылке, отправленной на ваш E-mail: test@test.ru
  end

  def confirm_header2
    begin
      find_element(:xpath, ".//*[@class='modal-dialog']/h3").text #Регистрация!
    rescue
      nil
    end
  end

  def confirm_message2
    find_element(:xpath, ".//*[@class='modal-dialog']/div[2]").text #Email успешно подтвержден.
  end

  def confirm_button2
    find_element(:xpath, ".//*[@class='modal-dialog']/div[3]/button")
  end

  def ava_enabled?
    begin
      find_element(:class, "name").text
    rescue
      nil
    end
  end


  def clear
    emailInput.clear
    pswRegister.clear
    pswRepeat.clear
  end

  def registration(email, pass, passRep)
    clear
    emailInput.click
    emailInput.send_keys email
    pswRegister.send_keys pass
    pswRepeat.send_keys passRep
    createAccBtn.click
    reg = begin
      @wait.until { confirm_header }
      true
    rescue Selenium::WebDriver::Error::TimeOutError
      false
      end
    if reg
    else
      @emailShort = emailShort
      @emailFormat = emailFormat
      @passwordShort = passwordShort
      @passwordsDiffer = passwordsDiffer
    end
  end

  def clickLink
    confirm_button2.click
    getMailLink
    confirm_button.click
    ava = begin
      @wait.until { ava_enabled? }
      true
    rescue Selenium::WebDriver::Error::TimeOutError
      false
    end
    if ava
    else
      nil
    end
  end

end