require 'rubygems'
require 'selenium-webdriver'

class Test

  def initialize
    @driver = Selenium::WebDriver.for :firefox, marionette: true
    @start_url = "http://qa-web-test-task.s3-website.eu-central-1.amazonaws.com/"
    @veri_text = "последняя"
  end

  def quit
    @driver.quit
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

  def open_page
    @driver.get @start_url
  end

  def final_text
    if e = element(:xpath, "html/body/h2") { |el| el.text }
      e
    else
      ""
    end
  end

  def link_enabled
    element(:xpath, "html/body/a") { |el| el.enabled? }
  end

  def test
    page_number = 1
    until final_text.include? @veri_text do
      @driver.get @start_url + "#{page_number}.html"
      if link_enabled
      else puts "Номера страниц без ссылки - #{page_number}.html"
      # puts @driver.current_url  #или вывод самих ссылок
      end
      page_number = page_number + 1
    end
  end
end