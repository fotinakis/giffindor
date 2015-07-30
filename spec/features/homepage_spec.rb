RSpec.describe :homepage, js: true do
  before(:each) do
    gif_post = create(:gif_post, url: 'http://media.giphy.com/media/bJJAX2itSzNW8/giphy.gif')
    login_as(gif_post.user)
  end
  it 'loads and shows gifs' do
    visit '/'
    expect(page).to have_content('Recently Shared Gifs')
    expect(page).to have_content('test-user')

    Percy::Capybara.snapshot(page, name: 'homepage')
  end
end