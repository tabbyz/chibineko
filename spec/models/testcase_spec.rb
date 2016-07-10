require 'rails_helper'

RSpec.describe Testcase, type: :model do
  let(:testcase) { create(:testcase, test: create(:test)) }
  let(:testcases) { [testcase] }

  describe '#type' do
    context 'with type -1' do
      it 'returns :blnak' do
        testcase.heading_level = -1
        expect(testcase.type).to be(:blank)
      end
    end
    context 'with type 0' do
      it 'returns :blnak' do
        testcase.heading_level = 0
        expect(testcase.type).to be(:testcase)
      end
    end
    context 'with other type' do
      it 'returns :heading' do
        testcase.heading_level = 1
        expect(testcase.type).to be(:heading)
      end
    end
  end

  describe '#result_color' do
    context 'with valid result' do
      it 'returns matching color' do
        testcase.result = 'PASS'
        expect(testcase.result_color).to eq('green')

        testcase.result = 'NOT RUN'
        expect(testcase.result_color).to eq('white')

        testcase.result = 'FAIL'
        expect(testcase.result_color).to eq('red')

        testcase.result = 'BLOCKED'
        expect(testcase.result_color).to eq('orange')

        testcase.result = 'N/A'
        expect(testcase.result_color).to eq('gray')
      end
    end

    context 'with invalid result' do
      it 'returns white color' do
        testcase.result = 'INVALID_COLOR'
        expect(testcase.result_color).to eq('white')
      end
    end
  end

  describe 'heading_level' do
    context 'with blank' do
      it 'returns -1' do
        expect(Testcase.heading_level('')).to eq(-1)
      end
    end
    context 'start with #' do
      it 'returns heading_level' do
        expect(Testcase.heading_level('#level1')).to eq(1)
        expect(Testcase.heading_level('##level2')).to eq(2)
      end
    end
    context 'not start with #' do
      it 'returns 0' do
        expect(Testcase.heading_level('test')).to eq(0)
      end
    end
  end

  describe 'body' do
    context 'with blank' do
      it 'returns nil' do
        expect(Testcase.body('')).to eq(nil)
      end
    end

    context 'with head' do
      it 'returns body removed #' do
        expect(Testcase.body('#level1')).to eq('level1')
        expect(Testcase.body('##level2')).to eq('level2')
      end
    end

    context 'with no head' do
      it 'returns body' do
        text = 'testcase, [PASS], test_note'
        expect(Testcase.body(text)).to eq('testcase')
      end
    end
  end

  describe 'result' do
    context 'with blank' do
      it 'returns nil' do
        expect(Testcase.result('')).to eq(nil)
      end
    end

    context 'with valid text' do
      it 'returns result' do
        expect(Testcase.result('testcase, [PASS], test_note')).to eq('PASS')
      end
    end

    context 'with invalid text' do
      it 'returns nil' do
        expect(Testcase.result('invalid text')).to eq(nil)
      end
    end
  end

  describe 'note' do
    context 'with blank' do
      it 'returns nil' do
        expect(Testcase.note('')).to eq(nil)
      end
    end

    context 'with valid text' do
      it 'returns note' do
        expect(Testcase.note('testcase, [PASS], test_note')).to eq('test_note')
      end
    end

    context 'with invalid text' do
      it 'returns nil' do
        expect(Testcase.note('invalid text')).to eq(nil)
      end
    end
  end
end
