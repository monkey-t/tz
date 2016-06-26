# coding: utf-8
require 'rspec'
require 'selenium-webdriver'
require_relative '../obj/obj'

describe 'Test' do
  app = nil
  before(:all) do
    app = Test.new(Selenium::WebDriver.for :firefox)
    # начало проверки (тырка тырка до кнопки 2.хтмл)
    app.start_test
  end

  before(:each) do
    app.qwe
  end

  after(:all) do
    app.quit
  end

  it 'find_last_page' do #находим все ноулинки до последней страницы
    find_last_page
  end

  it 'find_linit_value' do

  end

  # проверка последней страницы (наличие слова последяя)


  it 'wrongPsw' do
    app
        .login('tester@tester.net', '123321')
    expect(app.wrongPsw).to be == 'Неверный пароль'
  end

end
