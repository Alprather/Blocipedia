require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:wiki) { Wiki.create!(title: "New Wiki Title", body: "New wiki Body") }

   describe "attributes" do
     it "responds to title" do
       expect(wiki).to respond_to(:title)
     end
     it "responds to body" do
       expect(wiki).to respond_to(:body)
     end
   end
end
