require 'acceptance/acceptance_helper'

feature 'Signup:', %q{
  In order to start using the app
  Users should be able to signup
  And link with an OAuth provider
} do
 
  #VCR will record interactions if cassette file doesn't exist, otherwise it will use what's in the cassette
  use_vcr_cassette 'registration', :record => :once
 
  #This is a nice little tweak, that saves the current state of the browser on a spec fail and opens it
  after do
    if example.exception
      page.driver.render('testoutput.png')
      `open testoutput.png`
    end
  end
 
 
 
  background do
    visit '/'
  end
 
  #If your app relies on JS, don't forget :js => true, or you will hate yourself
  scenario 'create an account', :js => true do
 
    #skips any jQuery animations, for speed
    page.driver.evaluate_script('$.fx.off = true')
    
    #First we just want to fill in the form and submit
    fill_fields({
      "Email" => "phil@floatapp.com", 
      "Password" => "password"
    })
    
    click_button "Start your free trial!"
 
    # This is where it gets interesting. If we are recording the VCR cassette, we want to
    # actually go through the interaction with the third party. These steps will depend on the
    # third-party
    if VCR.current_cassette.recording?
      page.should have_content 'Please log in'
      fill_fields({
        :email => "my_username",
        :password => "my_password"
      })
      find(:css, 'input[type=submit]').click
      find(:css, 'a[href="grant_approval"]').click
 
      # This will take us back to our callback /oauth/callback with a real code. 
      # This code will be upgraded, and all the interactions for doing so will be recorded for next time
    else
      #If we are not recording, skip the third party stuff, and use the recorded token upgrade
      visit '/oauth/callback?code=fake'
    end
 
    page.should have_content "Welcome!"
 
  end
end