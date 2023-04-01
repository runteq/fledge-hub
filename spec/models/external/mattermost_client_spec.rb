require 'rails_helper'

RSpec.describe External::MattermostClient do
  describe '#post' do
    it 'Faraday::Connection のインスタンスにpostしていること' do
      client_double = instance_double(Faraday::Connection)
      allow(Faraday::Connection).to receive(:new).and_return(client_double)
      expect(client_double).to receive(:post)

      External::MattermostClient.new.post({ payload: 'payload' })
    end
  end
end
