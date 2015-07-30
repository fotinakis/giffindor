RSpec.feature :homepage, js: true do
  let(:jumping_kitten_url) { 'http://cdn.shopify.com/s/files/1/0645/5501/files/kitty-cat-jumping_large.png?449' }
  let(:fluffy_cat_url) { 'http://24.media.tumblr.com/tumblr_m0c6acj3vW1rq4dn9o1_500.png' }
  before(:each) do
    user = create(:user)
    create(:gif_post, body: 'jumping kitten', user: user, url: jumping_kitten_url)
    create(:gif_post, body: 'fluffy cat jump', user: user, url: fluffy_cat_url)
    login_as(user)
  end

  def finished_all_animations?
    page.evaluate_script('$(":animated").length') == 0
  end

  def wait_for_animation
    Timeout.timeout(Capybara.default_wait_time) do
      sleep 0.1 until finished_all_animations?
    end
  end

  scenario 'user opens page and views images' do
    visit '/'
    expect(page).to have_content('Recently Shared Gifs')
    expect(page).to have_content('test-user')

    Percy::Capybara.snapshot(page, name: 'homepage')
  end

  scenario 'user clicks Submit A Gif and input section appears' do
    visit '/'
    expect(page).to have_content('test-user')
    find('#toggle-post-dialog').click
    wait_for_animation
    expect(page).to have_content('Share a gif')

    Percy::Capybara.snapshot(page, name: 'homepage with input')
  end

  scenario 'user tries to submit a PNG and gets an error' do
    visit '/'
    expect(page).to have_content('test-user')
    find('#toggle-post-dialog').click
    wait_for_animation
    expect(page).to have_content('Share a gif')
    fill_in 'new-gif-post', with: fluffy_cat_url
    expect(page).to have_content('There is no valid gif link in this post')

    Percy::Capybara.snapshot(page, name: 'homepage with input and error')
  end
end