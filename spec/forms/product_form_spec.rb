require 'rails_helper'

RSpec.describe ProductForm do
  describe '#save' do
    subject { form.save }
    let!(:form) { ProductForm.new(**attributes) }

    context 'バリデーションエラー' do
      let!(:user) { create(:user, :active) }
      let!(:attributes) do
        {
          title: '', # バリデーションエラー
          url: '',
          source_url: '',
          released_on: '2021-06-17',
          summary: '',
          genre_id: '', # バリデーションエラー
          technology_ids: [''],
          user_ids: [user.id],
        }
      end

      it { expect(subject).to be false }
      it 'レコードを作成しない' do
        expect { subject }.not_to change(Product, :count)
      end
      it 'エラーメッセージを持つ' do
        subject
        expect(form.errors.messages).to eq({ title: ['を入力してください'], genre_id: ['を入力してください'] })
      end
    end

    context '正常系' do
      let!(:user) { create(:user, :active) }
      let!(:technology) { create(:technology) }
      let!(:attributes) do
        {
          title: 'タイトル',
          url: '',
          source_url: '',
          released_on: '2021-06-17',
          summary: '',
          genre_id: '1',
          technology_ids: [technology.id.to_s],
          user_ids: [user.id],
        }
      end

      it { expect(subject).to be true }
      it 'レコードを作成する' do
        expect { subject }.to change(Product, :count).by(1)
                          .and change(UserProduct, :count).by(1)
                          .and change(ProductTechnology, :count).by(1)
      end
    end
  end
end
