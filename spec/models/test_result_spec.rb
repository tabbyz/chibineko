require 'rails_helper'

RSpec.describe TestResult, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe 'result' do
    context 'with blank' do
      it 'returns nil' do
        expect(TestResult.result('')).to eq(nil)
      end
    end
  end
end
