require 'rails_helper'

RSpec.describe UpdateRubyJobs, type: :interactor do
  context = UpdateRubyJobs.call
  it "should return something" do
    expect(context.message).to eq("pending")
  end
end
