require_relative '../factories/user'


feature 'User sign-up' do

  scenario 'I can sign up as a new user' do
    user = build :user
    expect{sign_up_as(user)}.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'with a password that does not match' do
    user = build :user, password_confirmation: 'wrong'
    expect{sign_up_as(user)}.not_to change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'user can\'t sign up without entering an email' do
    user = build :user, email: nil
    expect{sign_up_as(user)}.not_to change(User, :count)
  end

  scenario 'I cannot sign up with an existing email' do
    user = build :user
    sign_up_as(user)
    expect{sign_up_as(user)}.to change(User, :count).by(0)
    expect(page).to have_content 'Email is already taken'
  end

end

feature 'User can sign in' do

  let(:user) {create :user}

  scenario 'with correct credentials' do
    sign_in_as(user)
    expect(page).to have_content "Welcome, #{user.email}"
  end

end

feature 'User signs out' do

  scenario 'while being signed in' do
    user = create :user
    sign_in_as(user)
    click_button 'Sign out'
    expect(page).to have_content('Goodbye!')
    expect(page).not_to have_content("Welcome, #{user.email}")
  end

end
