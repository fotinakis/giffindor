RSpec.feature :second, js: true do
  let(:jumping_kitten_url) { 'http://cdn.shopify.com/s/files/1/0645/5501/files/kitty-cat-jumping_large.png?449' }
  let(:gif_image_url) { 'https://media.giphy.com/media/ardMfW1w53UvC/giphy.gif' }
  before(:each) do
    user = create(:user)
    create(:gif_post, body: 'jumping kitten', user: user, url: jumping_kitten_url)
    create(:gif_post, body: 'fluffy cat jump', user: user, url: gif_image_url)
    login_as(user)
  end

  scenario 'user opens page and views images' do
    visit '/'
    expect(page).to have_content('Recently Shared Gifs')
    expect(page).to have_content('test-user')

    Percy::Capybara.snapshot(page, name: 'homepage from parallel')
  end
end