require 'rails_helper'

RSpec.describe SettingsTabComponent, type: :component do
  context 'tab_pathが現在のパスのとき' do
    before do
      render_inline(described_class.new(tab_name: 'タブの名前', tab_path: '/'))
      expect(request.path).to eq '/'
    end

    specify { expect(rendered_component).to have_text 'タブの名前' }
    it 'リンクにならないこと' do
      expect(rendered_component).to have_css 'li'
      expect(rendered_component).not_to have_css 'a'
    end
  end

  context 'tab_pathが現在のパスではないとき' do
    before do
      render_inline(described_class.new(tab_name: 'タブの名前', tab_path: '/not_current_path'))
      expect(request.path).not_to eq '/not_current_path'
    end

    specify { expect(rendered_component).to have_text 'タブの名前' }
    it 'リンクになること' do
      expect(rendered_component).to have_css 'li'
      expect(rendered_component).to have_css 'a'
    end
  end
end
