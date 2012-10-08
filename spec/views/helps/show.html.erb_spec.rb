require 'spec_helper'

describe "helps/show.html.erb" do
  before(:each) do
    @help = assign(:help, stub_model(Help))
  end

  it "renders attributes in <p>" do
    render
  end
end
