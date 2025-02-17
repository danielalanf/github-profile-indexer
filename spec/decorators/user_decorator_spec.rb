require "rails_helper"

RSpec.describe UserDecorator do
  let(:user) { create(:user, :complete) }
  let(:decorated_user) { user.decorate }

  describe "#profile_image" do
    it "retorna a imagem padrao quando a image_url nao esta presente" do
      user.image_url = nil
      expect(decorated_user.profile_image).to include("assets/usuario-placeholder-5086554528c294d6d4f6057e8bfb4abccdffaf61710c2a814daa464a4575f1ef.png")
    end

    it "retorna a imagem quando possui a image_url" do
      expect(decorated_user.profile_image).to include("https://avatars.githubusercontent.com/u/1?v=4")
    end
  end

  describe "#github_link" do
    it "retorna o link para o perfil do GitHub quando a URL está correta" do
      expect(decorated_user.github_link).to include(user.original_github_url)
    end
  end

  describe "#followers" do
    it "retorna a quantidade de followers formatada" do
      expect(decorated_user.followers).to eq("24.1K")
    end
  end

  describe "#following" do
    it "retorna a quantidade de folowing formatada" do
      expect(decorated_user.following).to eq(11)
    end
  end

  describe "#stars" do
    it "retorna a quantidade de stars formatada" do
      expect(decorated_user.stars).to eq(160)
    end
  end

  describe "#last_year_contributions" do
    it "retorna a quantidade de last_year_contributions formatada" do
      expect(decorated_user.last_year_contributions).to eq(0)
    end
  end

  describe "#location_with_icon" do
    it "retorna a location com o icone quando location esta presente" do
      expect(decorated_user.location_with_icon).to include("San Francisco")
      expect(decorated_user.location_with_icon).to include("fa-map-marker-alt")
    end

    it "retorna nil quando location nao esta presente" do
      user.location = nil
      expect(decorated_user.location_with_icon).to be_nil
    end
  end

  describe "#organization_with_icon" do
    it "retorna a organization com o icone quando organization esta presente" do
      expect(decorated_user.organization_with_icon).to include("@chatterbugapp, @redwoodjs, @preston-werner-ventures")
      expect(decorated_user.organization_with_icon).to include("fa-building")
    end

    it "retorna nil quando organization nao esta presente" do
      user.organization = nil
      expect(decorated_user.organization_with_icon).to be_nil
    end
  end
end
