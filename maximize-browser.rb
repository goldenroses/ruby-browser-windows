require 'selenium-webdriver'
require 'test-unit'

class BrowserWindowTests < Test::Unit::TestCase
  def setup
    username = "#{ENV['LAMBDATEST_USERNAME']}"
    access_token = "#{ENV['LAMBDATEST_ACCESS_KEY']}"
    grid_url = "hub.lambdatest.com/wd/hub"

    capabilities = {
      'LT:Options' => {
        "user" => username,
        "accessKey" => access_token,
        "build" => "Browser Maximizing Test v.1",
        "name" => "Browser Maximizing Tests",
        "platformName" => "Windows 11"
      },
      "browserName" => "Firefox",
      "browserVersion" => "100.0",
    }


    @my_driver = Selenium::WebDriver.for(:remote,
                                         :url => "https://"+username+":"+access_token+"@"+grid_url,
                                         :capabilities => capabilities)


    @url = "https://ecommerce-playground.lambdatest.io/"

    #get url
    @my_driver.get(@url)
    @wait = Selenium::WebDriver::Wait.new(:timeout => 30)
  end

  def test_page_resizing
    # Assert that title is loaded
    @wait.until { @my_driver.title.include? "Your Store" }
    sleep(2)

    # We maximize the window to occupy the full page
    @my_driver.manage.window.maximize

    # Here we minimize the browser window to the task bar
    @my_driver.manage.window.minimize
    sleep(2)

    # Here we resize the browser window to a width and height of 500(width) by 1000(height)
    @my_driver.manage.window.resize_to(500, 1000)
    sleep(2)

    # We maximize the broser window again to occupy the full page
    @my_driver.manage.window.maximize

    # We maximize the broser window again to occupy the full page
    puts @my_driver.manage.window.size

  end

  def teardown
    @my_driver.quit
  end
end
