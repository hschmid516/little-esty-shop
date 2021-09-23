require 'rails_helper'

RSpec.describe Discount do
  it { should belong_to(:merchant) }
end
