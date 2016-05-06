RSpec.feature :second, js: true do
  let(:jumping_kitten_url) { '/kitty-cat-jumping_large.png' }
  let(:gif_image_url) { '/duckhunt.gif' }
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
  end
end