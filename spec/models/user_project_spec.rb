require 'rails_helper'

RSpec.describe UserProject, type: :model do
  it { should belong_to(:user)}
  it { should belong_to(:project)}
end
