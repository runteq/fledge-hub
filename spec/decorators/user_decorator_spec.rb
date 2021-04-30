require 'rails_helper'

RSpec.describe UserDecorator do
  describe 'UserDecoratorに定義したメソッドが正常に動作すること' do
    describe 'github_user_name' do
      describe 'display_nameが空白の場合' do
        let(:user) { create :user, display_name: '', screen_name: 'screen_name_1' }
        subject { user.decorate }

        it 'screen_name_1と表示される' do
          expect(subject.github_user_name).to eq 'screen_name_1'
        end
      end

      describe 'display_nameが名前_1の場合' do
        let(:user) { create :user, display_name: '名前_1', screen_name: 'screen_name_1' }
        subject { user.decorate }

        it '名前_1と表示される' do
          expect(subject.github_user_name).to eq '名前_1'
        end
      end
    end
  end
end
