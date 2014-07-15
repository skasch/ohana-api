require 'rails_helper'

describe Category do
  subject { build(:category) }

  it { is_expected.to be_valid }

  it { is_expected.to allow_mass_assignment_of(:name) }
  it { is_expected.to allow_mass_assignment_of(:oe_id) }

  it { is_expected.to have_and_belong_to_many(:services) }

  it do
    is_expected.to validate_presence_of(:name).
      with_message("can't be blank for Category")
  end

  it do
    is_expected.to validate_presence_of(:oe_id).
      with_message("can't be blank for Category")
  end
end