require 'rails_helper'

RSpec.describe Pitch do 
    describe 'relationships' do 
        it { should belong_to(:pitcher) }
        it { should belong_to(:game) }
    end
end