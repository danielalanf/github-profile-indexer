require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "validations" do
    let(:invalid_user) { build(:user, :invalid_github) }
    let(:valid_user) { build(:user, :valid_github) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:github_url) }

    it "valida uniqueness de github_url" do
      user
      should validate_uniqueness_of(:github_url)
    end

    it "permite URLs válidas" do
      expect(user).to be_valid
    end

    it "não permite URLs inválidas" do
      expect(invalid_user).to_not be_valid
    end
  end

  describe "callbacks" do
    let(:new_user) { build(:user, :valid_github) }

    it "chama reindex após criar, atualizar ou excluir" do
      expect(user).to receive(:reindex)
      user.run_callbacks(:commit)
    end

    it "chama generate_shortner_url antes de salvar" do
      expect(new_user).to receive(:generate_shortner_url)
      new_user.run_callbacks(:save)
    end

    it "chama scrapper antes de salvar" do
      expect(new_user).to receive(:scrapper)
      new_user.run_callbacks(:save)
    end
  end

  describe "#rescanner" do
    it "chama o método scrapper" do
      expect(user).to receive(:scrapper)
      user.rescanner
    end
  end

  describe "#original_github_url" do
    let(:short_url) { ShortUrl.find_by(slug: user.github_url.split("/").last) }
    let(:github_url) { short_url.long_url }

    it "retorna a URL original do GitHub a partir do encurtador" do
      expect(user.original_github_url).to eq(github_url)
    end

    it "retorna nil se a URL encurtada não for encontrada" do
      short_url.destroy

      expect(user.original_github_url).to be_nil
    end
  end

  describe "#github_url_exists", vcr: { cassette_name: "github_profile" } do
    context "quando o perfil do GitHub existe" do
      it "não adiciona erro ao usuário" do
        VCR.use_cassette("github_profile_exists") do
          user.valid?
          expect(user.errors[:base]).to be_empty
        end
      end
    end

    context "quando o perfil do GitHub não existe" do
      let(:invalid_user) { build(:user, :invalid_github) }

      it "adiciona erro ao usuário" do
        VCR.use_cassette("github_profile_not_found") do
          invalid_user.valid?
          expect(invalid_user.errors[:base]).to include("profile not exist on github")
        end
      end
    end
  end
end
