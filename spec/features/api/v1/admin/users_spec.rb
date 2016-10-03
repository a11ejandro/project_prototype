RSpec.describe Api::V1::Admin::UsersController, type: :controller do
  before do
    request.accept = 'application/json'
    @user_1 = FactoryGirl.create(:user)
    @user_2 = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:user, :admin)
    @admin_device = FactoryGirl.create(:device, user: @admin)
  end

  it 'should update with valid token' do
    put :update, params: {id: @user_1.id, auth_token: @admin_device.auth_token, first_name: 'New Firstname', last_name: 'New Lastname',
                            role: QA, email: 'test_user@example.com'}
    @user_1.reload

    expect(json['status']).to be 200
    expect(@user_1.first_name).to eq 'New Firstname'
    expect(@user_1.last_name).to eq 'New Lastname'
    expect(@user_1.email).to eq 'test_user@example.com'

    expect(@user_1.role).to eq QA
  end

  it 'should not update with non-admin token' do
    @user_2_device = FactoryGirl.create(:device, user: @user_2)
    put :update, params: {id: @user_1.id, auth_token: @user_2_device.auth_token, first_name: 'New Firstname', last_name: 'New Lastname',
                            email: 'test_user@example.com', password: 'password'}
    
    expect(json['status']).to eq 401
    expect(json['result']).to eq BASE_ERRORS[:invalid_token]
    expect(@user_1.first_name).not_to eq 'New Firstname'
    expect(@user_1.last_name).not_to eq 'New Lastname'
    expect(@user_1.email).not_to eq 'test_user@example.com'
  end

  it 'should show any user' do
    get 'show', params: {id: @user_1.id, auth_token: @admin_device.auth_token}

    result = json['result']

    expect(json['status']).to eq 200
    expect(result['firstName']).to eq @user_1.first_name
    expect(result['lastName']).to eq @user_1.last_name
    expect(result['email']).to eq @user_1.email
    expect(result['role']).to eq @user_1.role
  end


  it 'should reset password' do
    post 'reset_password', params: {id: @user_1.id, email: @user_1.email, auth_token: @admin_device.auth_token}
    @user_1.reload

    email_source = ActionMailer::Base.deliveries.last.body.raw_source
    password_from_email = email_source.match(/<span>\n(.*)\n<\/span>/i).captures.first
    password_from_db = BCrypt::Password.new(@user_1.crypted_password)

    expect(password_from_db == password_from_email + @user_1.salt).to eq true
  end

  it 'should destroy user' do
    delete 'destroy', params: {id: @user_1.id, auth_token: @admin_device.auth_token}

    expect(json['status']).to eq 200
    expect(User.find_by id: @user_1.id).to be_nil
  end

  it 'should list users' do
    get 'index', params: {auth_token: @admin_device.auth_token}

    expect(json['status']).to eq 200
    expect(json['result']['users'].count).to eq 3
  end

  it 'should sort users' do
    @user_1.update(first_name: 'AAAAAA')
    @user_2.update(first_name: 'CCCCCC')
    @admin.update(first_name: 'BBBBBB')

    get 'index', params: {auth_token: @admin_device.auth_token, sort_field_name: 'first_name', sort_order: 'desc'}

    expect(json['result']['users'].map{|u| u['id']}).to eq [@user_2.id, @admin.id, @user_1.id]
  end

  it 'should filter users' do
    @user_1.update(first_name: 'AAAAAA')
    @user_2.update(first_name: 'BBBBBB')
    @admin.update(first_name: 'CCCCCC')

    get 'index', params: {auth_token: @admin_device.auth_token, search_phrase: 'AAAAAA'}
    expect(json['result']['users'].map{|u| u['id']}).to eq [@user_1.id]
  end

  it 'should paginate users' do
    get 'index', params: {auth_token: @admin_device.auth_token, page: 1, per_page: 1}

    expect(json['result']['users'].count).to eq 1
    expect(json['result']['pagination']['totalPages']).to eq 3
  end
end