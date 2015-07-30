RSpec.describe :homepage do
  it 'loads and shows gifs' do
    visit '/'
    expect(page).to have_content('Recently Shared Gifs')
  end
end