require 'rspec'
require 'cucumber'
require 'selenium/webdriver'
require 'selenium-webdriver'
require 'capybara'
require 'capybara/cucumber'
require 'allure-cucumber'
require 'pry'
require 'site_prism'

Capybara.register_driver :selenium do |globalweb|
	Capybara::Selenium::Driver.new(globalweb, :browser => :chrome)
end

Capybara.configure do |config|
    Capybara.default_driver = :selenium
    config.default_max_wait_time = 25
    Capybara.ignore_hidden_elements = false
    Capybara.page.driver.browser.manage.window.maximize
end

include AllureCucumber::DSL

AllureCucumber.configure do |report_yaman|
    report_yaman.output_dir = "log"
    report_yaman.clean_dir  = false
end

 class Cucumber::Core::Test::Step
    def name
      return text if self.text == 'Before hook'
      return text if self.text == 'After hook'
      "#{source.last.keyword}#{text}"
    end 
  end