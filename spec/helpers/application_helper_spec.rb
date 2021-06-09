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
end
