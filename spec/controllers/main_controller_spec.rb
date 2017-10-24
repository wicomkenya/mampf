require 'rails_helper'

RSpec.describe MainController, type: :controller do
  describe "#home" do
    it "returns http success" do
      get :home
      expect(response).to be_success
    end
  end
  
  describe "#about" do
    it "returns http success" do
      get :about
      expect(response).to be_success
    end
  end

end
