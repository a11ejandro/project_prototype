RSpec.describe Api::V1::UsersController, type: :controller do
  before do
    request.accept = 'application/json'
    @user = FactoryGirl.create(:user)
  end

  it 'should update with valid token and password' do
    put :update, params: {id: @user.id, rest_token: @user.rest_token, first_name: 'New Firstname', last_name: 'New Lastname',
                            role: ADMIN, email: 'test_user@example.com', password: 'password'}
    @user.reload

    expect(json['status']).to be 200
    expect(@user.first_name).to eq 'New Firstname'
    expect(@user.last_name).to eq 'New Lastname'
    expect(@user.email).to eq 'test_user@example.com'

    expect(@user.role).to eq REGULAR_USER
  end

  it 'should not update with wrong token' do
    put :update, params: {id: @user.id, rest_token: '', first_name: 'New Firstname', last_name: 'New Lastname',
                            email: 'test_user@example.com', password: 'password'}
    
    expect(json['status']).to eq 401
    expect(json['result']).to eq BASE_ERRORS[:invalid_token]
    expect(@user.first_name).not_to eq 'New Firstname'
    expect(@user.last_name).not_to eq 'New Lastname'
    expect(@user.email).not_to eq 'test_user@example.com'
  end

  it 'should not update with wrong password' do
    put :update, params: {id: @user.id, rest_token: @user.rest_token, first_name: 'New Firstname', last_name: 'New Lastname',
                          email: 'test_user@example.com', password: ''}

    expect(json['status']).to eq 401
    expect(json['result']).to eq BASE_ERRORS[:invalid_password]
    expect(@user.first_name).not_to eq 'New Firstname'
    expect(@user.last_name).not_to eq 'New Lastname'
    expect(@user.email).not_to eq 'test_user@example.com'
  end

  it 'should show any user' do
    @another_user = FactoryGirl.create(:user)
    get 'show', params: {id: @another_user.id, rest_token: @user.rest_token}

    expect(json['status']).to eq 200
    expect(json['first_name']).to eq @another_user.first_name
    expect(json['last_name']).to eq @another_user.last_name
    expect(json['email']).to eq @another_user.email
    expect(json['role']).to eq @another_user.role
  end

  it 'should not show user without token' do
    @another_user = FactoryGirl.create(:user)
    get 'show', params: {id: @another_user.id, rest_token: ''}

    expect(json['status']).to eq 401
    expect(json['result']).to eq BASE_ERRORS[:invalid_token]
  end

  it 'should update password with password confirmation' do
    old_encrypted = @user.crypted_password
    post 'update_password', params: {rest_token: @user.rest_token, old_password: 'password', new_password: 'new_password'}
    @user.reload

    expect(json['status']).to be 200
    expect(@user.crypted_password).to_not eq old_encrypted
  end

  it 'should reset password' do
    post 'reset_password', params: {email: @user.email}
    @user.reload

    email_source = ActionMailer::Base.deliveries.last.body.raw_source
    password_from_email = email_source.match(/<span>\n(.*)\n<\/span>/i).captures.first
    password_from_db = BCrypt::Password.new(@user.crypted_password)

    expect(password_from_db == password_from_email + @user.salt).to eq true
  end
end