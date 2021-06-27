require 'rails_helper'

RSpec.describe LinkHelper, type: :helper do
  describe '#link_to_blank' do
    subject { helper.link_to_blank(text, url) }

    context '正常系' do
      let!(:text) { 'テキスト' }
      let!(:url) { 'http://example.com/hoge' }
      specify do
        is_expected.to eq '<a target="_blank" rel="noopener noreferrer" href="http://example.com/hoge">テキスト</a>'
      end
    end

    context 'textがnilのとき' do
      let!(:text) { nil }
      let!(:url) { 'http://example.com/hoge' }
      specify do
        is_expected.to eq '<a target="_blank" rel="noopener noreferrer" href="http://example.com/hoge">http://example.com/hoge</a>'
      end
    end

    context '不適なURLのとき' do
      let!(:text) { 'テキスト' }
      let!(:url) { 'http://example.com/hoge?q=ほげ' }
      specify { expect { subject }.to raise_error URI::InvalidURIError }
    end
  end

  describe '#link_to_active' do
    subject { helper.link_to_active(user) }

    context 'ユーザーが退会していないとき' do
      let!(:user) { create(:user, :active) }
      it { is_expected.to eq "<a href=\"/users/#{user.screen_name}\">#{user.display_name}</a>" }
    end

    context 'ユーザーが退会しているとき' do
      let!(:user) { create(:user, :deactivated) }
      it { is_expected.to eq '退会済みユーザー' }
    end
  end
end
