require 'rails_helper'

describe 'Siesta::TestSuite' do
  describe '.groups' do
    let(:spec_dir) { 'spec/javascripts' }
    context 'when t.js file in spec_javascripts' do
      let(:test_suite) { Siesta::TestSuite.new(spec_dir) }
      let(:test_file) { File.join(spec_dir, 'sample.t.js') }
      before do
        allow(Dir).to receive(:glob).and_return([test_file])
        allow(test_suite).to receive(:has_tests?).with(spec_dir).and_return(true)
        allow(test_suite).to receive(:has_tests?).with(test_file).and_return(false)
      end
      it 'returns group global' do
        expect(test_suite.groups.map(&:name)).to be == ['global']
      end
      describe '.items' do
        it 'returns one item' do
          expect(test_suite.groups[0].items.map(&:url)).to be == ['/assets/sample.t.js']
        end
      end
    end
    context 'when t.js.coffee file in spec_javascripts' do
      let(:test_suite) { Siesta::TestSuite.new(spec_dir) }
      let(:test_file) { File.join(spec_dir, 'sample.t.js.coffee') }
      before do
        allow(Dir).to receive(:glob).and_return([test_file])
        allow(test_suite).to receive(:has_tests?).with(spec_dir).and_return(true)
        allow(test_suite).to receive(:has_tests?).with(test_file).and_return(false)
      end
      it 'returns group global' do
        expect(test_suite.groups.map(&:name)).to be == ['global']
      end
      describe '.items' do
        it 'returns one item' do
          expect(test_suite.groups[0].items.map(&:url)).to be == ['/assets/sample.t.js']
        end
      end
    end
    context 'when t.js and t.js.coffee files in spec_javascripts' do
      let(:test_suite) { Siesta::TestSuite.new(spec_dir) }
      before do
        allow(Dir).to receive(:glob).and_return(['spec/javascripts/sample.t.js.coffee', 'spec/javascripts/sample_2.t.js'])
        allow(test_suite).to receive(:has_tests?).with(spec_dir).and_return(true)
        allow(test_suite).to receive(:has_tests?).with('spec/javascripts/sample.t.js.coffee').and_return(false)
        allow(test_suite).to receive(:has_tests?).with('spec/javascripts/sample_2.t.js').and_return(false)
      end
      it 'returns group global' do
        expect(test_suite.groups.map(&:name)).to be == ['global']
      end
      describe '.items' do
        it 'returns two URLs' do
          expect(test_suite.groups[0].items.map(&:url)).to be == ['/assets/sample.t.js', '/assets/sample_2.t.js']
        end
      end
    end
  end
end