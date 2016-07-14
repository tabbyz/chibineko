require 'rails_helper'

RSpec.describe Test, type: :model do
  let(:test) { create(:test) }
  let(:labels) {
      result_labels = I18n.t("tests.result_labels")
      {
        result_labels[:unexecuted] => "white",
        result_labels[:pass] => "green",
        result_labels[:fail] => "red",
        result_labels[:blocked] => "orange",
        result_labels[:na] => "gray",
      }
  }

  describe '#result_labels_or_default' do
    it 'returns labels' do
      expect(test.result_labels_or_default).to eq(labels)
    end

    it 'memoize labels' do
      labels = I18n.t("tests.result_labels")
      expected_labels = {
        labels[:memoized_key] => "memoized_value"
      }
      test.result_labels = expected_labels

      expect(test.result_labels_or_default).to eq(expected_labels)
    end
  end

  describe '#result_label_texts' do
    it 'returns label keys' do
      expect(test.result_label_texts).to eq(labels.keys)
    end
  end

  describe '#result_label_colors' do
    it 'returns label values' do
      expect(test.result_label_colors).to eq(labels.values)
    end
  end

  describe '#testcase_groups' do
    let(:group_a) {
      [build(:testcase, heading_level: 1), build(:testcase, heading_level: 0)]
    }

    let(:group_b) {
      [build(:testcase, heading_level: 1), build(:testcase, heading_level: 0)]
    }

    it 'groups testcases' do
      test.testcases = [group_a, group_b].flatten
      expect(test.testcase_groups).to eq([group_a, group_b])
    end
  end

  describe '#set_markdown' do
    let(:testcases) {
      [
        build(:testcase, heading_level: 1, body: 'heading_level_1'),
        build(:testcase, heading_level: 2, body: 'heading_level_2'),
        build(:testcase, heading_level: 0, body: 'testcase', result: 'test_result', note: 'test_note'),
        build(:testcase, heading_level: -1, body: 'blank')
      ]
    }

    context 'with with_result option' do
      it 'sets testcases as markdown with result' do
        test.testcases = testcases
        expect(test.set_markdown(true)).to eq("# heading_level_1\n## heading_level_2\ntestcase, [test_result], test_note\n")
      end
    end

    context 'without with_result option' do
      it 'sets testcases as markdown' do
        test.testcases = testcases
        expect(test.set_markdown).to eq("# heading_level_1\n## heading_level_2\ntestcase\n")
      end
    end
  end

  describe '#make_testcase' do
    let(:markdown) {
      "# heading_level_1\n## heading_level_2\ntestcase, [test_result], test_note\n"
    }

    it 'creates testcases form markdown' do
      test.testcases.delete_all
      test.markdown = markdown
      test.make_testcase

      expect(test.testcases.any? {|tc| tc.heading_level == 1 && tc.body == "heading_level_1" }).to be_truthy
      expect(test.testcases.any? {|tc| tc.heading_level == 2 && tc.body == "heading_level_2" }).to be_truthy
      expect(test.testcases.any? {|tc| tc.heading_level == 0 && tc.body == "testcase" && tc.result == "test_result" && tc.note == "test_note" }).to be_truthy
    end
  end
end
