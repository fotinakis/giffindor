RSpec.feature :homepage, js: true do
  let(:jumping_kitten_url) { 'http://cdn.shopify.com/s/files/1/0645/5501/files/kitty-cat-jumping_large.png?449' }
  let(:gif_image_url) { 'https://media.giphy.com/media/ardMfW1w53UvC/giphy.gif' }

  def disable_animations
    page.execute_script('$.fx.off = true')
  end

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

  scenario 'user clicks Submit A Gif and input section appears' do
    visit '/'
    expect(page).to have_content('test-user')
    disable_animations

    find('#toggle-post-dialog').click
    expect(page).to have_content('Share a gif')
  end

  scenario 'user tries to submit a PNG and gets an error' do
    visit '/'
    expect(page).to have_content('test-user')

    find('#toggle-post-dialog').click
    expect(page).to have_content('Share a gif')

    fill_in 'new-gif-post', with: jumping_kitten_url
    expect(page).to have_content('There is no valid gif link in this post')
  end
end