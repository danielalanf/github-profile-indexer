require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.create(:user) }

  let!(:user1) { create(:user, name: "Daniel Alan Faria", github_url: "http://www.github.com/daniel-alan-faria") }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
