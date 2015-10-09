require "rails_helper"

describe Siesta::ApplicationHelper do
  describe '#include_siesta_config' do
    context 'when a customized config exists' do
      before do
        allow(Rails.application.assets).to receive(:find_asset).with('siesta_config.js').and_return(true)
      end

      it 'includes the config' do
        expect(helper.include_siesta_config).to eql('<script src="/assets/siesta_config.js" type="text/javascript"></script>')
      end
    end   

    context 'when no customized config exists' do
      before do
        allow(Rails.application.assets).to receive(:find_asset).with('siesta_config.js').and_return(false)
      end

      it 'includes the default config' do
        expect(helper.include_siesta_config).to eql('<script src="/assets/siesta/siesta_config.js" type="text/javascript"></script>')
      end
    end
  end
end
