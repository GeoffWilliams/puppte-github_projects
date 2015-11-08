require 'spec_helper'
describe 'github_projects' do

  context 'with defaults for all parameters' do
    it { should contain_class('github_projects') }
  end
end
