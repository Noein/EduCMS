require 'spec_helper'

describe "helps/index.html.erb" do
  before(:each) do
    assign(:helps, [
      stub_model(Help),
      stub_model(Help)
    ])
  end

  it "renders a list of helps" do
    render
  end
end
