require 'rails_helper'
require 'webmock/rspec'
WebMock.allow_net_connect!

RSpec.describe MattermostNotifier do
  describe '.call' do
    it '処理が実行できること' do
      WebMock.disable!(except: [:net_http])
      WebMock.stub_request(:post, 'https://channel.example.com').to_return(
        body: { text: 'テキスト' }.to_json,
        status: 200,
        headers: { 'Content-Type' => 'application/json' },
      )

      # expectしていない
      MattermostNotifier.call(text: 'テキスト')
    end
  end
end
