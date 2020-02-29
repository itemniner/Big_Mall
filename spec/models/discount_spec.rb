require "rails_helper"

describe Discount, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :percentage }
    it { should validate_presence_of :min_items }
  end

  describe "relationships" do
    it {should belong_to :merchant}
  end
end