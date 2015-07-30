RSpec.describe :homepage, js: true do
  before(:each) do
    user = create(:user)
    create(:gif_post, body: 'whoa jumping cat', user: user, url: 'http://cdn.shopify.com/s/files/1/0645/5501/files/kitty-cat-jumping_large.png?449')
    create(:gif_post, user: 'jumping kitten', user, url: 'http://24.media.tumblr.com/tumblr_m0c6acj3vW1rq4dn9o1_500.png')
    login_as(user)
  end

  it 'loads and shows gifs' do
    visit '/'
    expect(page).to have_content('Recently Shared Gifs')
    expect(page).to have_content('test-user')

    Percy::Capybara.snapshot(page, name: 'homepage')
  end
end