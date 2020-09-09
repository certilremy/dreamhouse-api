require 'rails_helper'

RSpec.describe House, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:favorites).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:description) }
  it { should validate_length_of(:name) }
end
