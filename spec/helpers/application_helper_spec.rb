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
      it { is_expected.to eq 'サービスの説明' }
    end
  end

  describe '#meta_image_url' do
    context '引数があるとき' do
      subject { helper.meta_image_url('URL') }
      it { is_expected.to eq 'URL' }
    end

    context '引数がないとき' do
      subject { helper.meta_image_url }
      it { is_expected.to eq 'デフォルトのOGP用URL' }
    end
  end
end
