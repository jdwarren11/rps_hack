require 'spec_helper'

describe RPS::PlayGame do

  before do
    @match = RPS::Match.new(4)
    @match.create!

    expect(RPS.orm).to receive(:find_match_by_id).and_return(@match)
  end

  it ''

end