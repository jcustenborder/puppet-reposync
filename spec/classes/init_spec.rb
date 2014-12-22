require 'spec_helper'
describe 'reposync' do

  context 'with defaults for all parameters' do
    it { should contain_class('reposync') }
  end
end
