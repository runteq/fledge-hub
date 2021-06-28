require 'rails_helper'

RSpec.describe RegistrationsController, type: :request do
  describe 'GET /new' do
    subject { get '/registration/new' }

    context 'ログインしているとき' do
      it 'root_pathにリダイレクトする' do
        user = create(:user, :active)
        login_as(user)

        subject
        expect(response).to redirect_to(root_url)
      end
    end

    context 'session[:user_info]に値が入っていないとき' do
      it 'root_pathにリダイレクトする' do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({})
        subject
        expect(response).to redirect_to(root_url)
      end
    end

    context 'session[:user_info]に値が入っているとき' do
      it 'ページを描画する' do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(
          {
            user_info: {
              'screen_name' => 'screen_name',
              'display_name' => '',
              'email' => 'example@example.com',
            },
          },
        )

        subject
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST /create' do
    context 'ログインしているとき' do
      it 'root_pathにリダイレクトする' do
        user = create(:user, :active)
        login_as(user)

        post '/registration'
        expect(response).to redirect_to(root_url)
      end
    end

    context 'session[:user_info]に値が入っていないとき' do
      let(:attributes) { nil }
      it 'root_pathにリダイレクトする' do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({})

        post '/registration'
        expect(response).to redirect_to(root_url)
      end
    end

    context 'session[:user_info]に値が入っているとき' do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(
          {
            user_info: {
              'id' => Random.new_seed,
              'avatar_url' => 'http://i.pravatar.cc/300',
              'login' => 'github_account_name',
            },
          },
        )
      end

      context '利用規約に同意していないとき' do
        subject do
          post '/registration', params: {
            user: {
              screen_name: 'screen_name',
              display_name: '表示名',
              email: 'example@example.com',
            },
          }
        end

        it 'ユーザーを作成しない' do
          expect { subject }.not_to change(User, :count)
        end

        it 'return 422' do
          subject
          expect(response.status).to eq(422)
        end
      end

      context 'バリデーションエラー' do
        subject do
          post '/registration', params: {
            acceptable: 'true',
            user: {
              screen_name: '', # バリデーションエラー
              display_name: '表示名',
              email: 'example@example.com',
            },
          }
        end

        it 'ユーザーを作成しない' do
          expect { subject }.not_to change(User, :count)
        end

        it 'return 422' do
          subject
          expect(response.status).to eq(422)
        end
      end

      context '値が適切なとき' do
        subject do
          post '/registration', params: {
            acceptable: 'true',
            user: {
              screen_name: 'screen_name',
              display_name: '表示名',
              email: 'example@example.com',
            },
          }
        end

        it 'ユーザーが作成される' do
          expect { subject }.to change(User, :count).by(1)
                            .and change(Authentication, :count).by(1)
        end

        it 'ログインする' do
          subject
          expect(logged_in?).to eq true
        end

        it 'redirects to root_path' do
          subject
          expect(response).to redirect_to(root_url)
        end
      end
    end
  end
end
