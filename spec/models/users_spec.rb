require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:houses).dependent(:destroy) }
  it { should have_many(:favorites).dependent(:destroy) }
  it { should validate_presence_of(:username) }
  it { should validate_length_of(:username) }
end
