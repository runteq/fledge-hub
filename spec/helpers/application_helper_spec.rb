require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#page_title' do
    context '引数があるとき' do
      subject { helper.page_title('タイトル') }
      it { is_expected.to eq 'タイトル - Fledge Hub' }
    end

    context '引数がないとき' do
      subject { helper.page_title }
      it { is_expected.to eq 'Fledge Hub' }
    end
  end

  describe '#description' do
    context '引数があるとき' do
      subject { helper.description('テキスト') }
      it { is_expected.to eq 'テキスト' }
    end

    context '引数がないとき' do
      subject { helper.description }
      it { is_expected.to eq '個人開発者のための、技術を検索できる開発サービス投稿サイト' }
    end
  end

  describe '#meta_image_url' do
    context '引数があるとき' do
      subject { helper.meta_image_url('URL') }
      it { is_expected.to eq 'URL' }
    end

    context '引数がないとき' do
      subject { helper.meta_image_url }
      it { is_expected.to eq 'https://i.gzn.jp/img/2018/01/15/google-gorilla-ban/00.jpg' }
    end
  end
end
