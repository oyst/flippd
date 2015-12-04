module Helpers
  def sign_in(from: '/')
    OmniAuth.config.test_mode = false
    visit from
    click_on 'Sign In' if page.has_link?('Sign In')

    fill_in 'Name', with: 'Joe Bloggs'
    fill_in 'Email', with: 'joe@bloggs.com'
    click_on 'Sign In'
  end

  def fail_to_sign_in(from: '/')
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:developer] = 'Invalid credentials'.to_sym
    visit from
    click_on 'Sign In' if page.has_link?('Sign In')
  end

  def sign_out
    click_on 'Sign Out'
  end

  def submit_comment(from: '/videos/1')
    sign_in
    visit from
    fill_in 'message', with: 'This is a test comment'
    click_on 'Add Comment'
  end
end

OmniAuth.config.logger.level = Logger::UNKNOWN
