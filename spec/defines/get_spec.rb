require 'spec_helper'
describe 'github_projects::get', :type => :define do

  let :pre_condition do
    'include github_projects'
  end
  context "compiles successfully" do
    let :title do
      "/tmp/github"
    end
    let :params do
      {
        :github_user => "FooBar",
        :local_user  => "freddy",
        :token       => "topsecr3t",
      }
    end
    it { should compile }
  end
end
