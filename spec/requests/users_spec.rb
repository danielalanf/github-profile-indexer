require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe "GET #index" do
    context "quando há filtro de usuários" do
      it "retorna os usuários filtrados" do
        allow_any_instance_of(UserFilter).to receive(:valid?).and_return(true)
        allow(Elastic::UserSearchQuery).to receive_message_chain(:new, :search, :results).and_return([ user ])
        get :index, params: { user_filter: { name: user.name } }
        expect(assigns(:results)).to include(user)
      end
    end

    context "quando não há filtro de usuários" do
      it "retorna uma lista vazia" do
        get :index
        expect(assigns(:results)).to eq([])
      end
    end
  end

  describe "GET #show" do
    it "atribui o usuário correto" do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET #new" do
    it "atribui um novo usuário" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    context "com parâmetros válidos" do
      it "cria um novo usuário" do
        expect {
          post :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end
    end

    context "com parâmetros inválidos" do
      it "não cria um usuário" do
        expect {
          post :create, params: { user: { name: "", github_url: "" } }
        }.not_to change(User, :count)
      end
    end
  end

  describe "PATCH #update" do
    context "com parâmetros válidos" do
      it "atualiza o usuário" do
        patch :update, params: { id: user.id, user: { name: "Novo Nome", github_url: user.original_github_url } }
        user.reload
        expect(user.name).to eq("Novo Nome")
      end
    end

    context "com parâmetros inválidos" do
      it "não atualiza o usuário" do
        patch :update, params: { id: user.id, user: { name: "" } }
        user.reload
        expect(user.name).not_to eq("")
      end
    end
  end

  describe "POST #rescan" do
    it "executa o rescan do usuário" do
      allow(user).to receive(:rescanner).and_return(true)
      post :rescan, params: { id: user.id }
      expect(flash[:success]).to eq("User was successfully rescanned.")
    end
  end

  describe "DELETE #destroy" do
    it "remove o usuário" do
      user
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end
  end
end
