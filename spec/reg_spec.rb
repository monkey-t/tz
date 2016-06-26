# coding: utf-8
require 'rspec'
require 'selenium-webdriver'
require 'mail'
require_relative '../Obj/reg_form'

describe 'registration' do
  app = nil
  mail = nil

  before(:all) do
    app = Reg_form.new(Selenium::WebDriver.for :firefox)
    app.delUser
    app.openPage
        .navigateToRegForm
    mail = Mail.defaults do
      retriever_method :pop3, :address    => "pop.rambler.ru",
                       :port       => 995,
                       :user_name  => 'mail',
                       :password   => 'Pass',
                       :enable_ssl => true
    end
  end

  before(:each) do
    app.reset
  end

  after(:all) do
    app.quit
  end

  it 'openForm' do
    expect(app.formName).to be == "Зарегистрироваться"
  end

  it 'emptyReg' do
    app
        .registration('', '', '')
    expect(app.emailShort).to be == "Поле e-mail обязательно к заполнению"
    expect(app.passwordShort).to be == "Пароль должен быть не короче 6 символов"
  end

  it 'wrongReg' do
    app
        .registration(WrongEmail, WrongPass, Pass)
    expect(app.emailFormat).to be == "Некорректный e-mail"
    expect(app.passwordShort).to be == "Пароль должен быть не короче 6 символов"
    expect(app.passwordsDiffer).to be == "Пароли не совпадают"
  end

  it 'regStep1' do
    app
        .registration(EmailRamb, Pass, Pass)
    expect(app.confirm_header).to be == "Вы успешно зарегистрировались"
    expect(app.confirm_message).to be == "Ссылка для подтверждения регистрации отправлена на указанную почту: test@test.ru"
  end

  it 'regStep2' do
    app.clickLink
    expect(app.ava_enabled?).to be == EmailRamb
  end

end