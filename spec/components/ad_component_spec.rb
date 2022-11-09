require 'rails_helper'

RSpec.describe AdComponent, type: :component do
  it 'ComponentにRUNTEQのURLが含まれていること' do
    render_inline(described_class.new)
    expect(rendered_component).to have_css '#ad'
  end
end
