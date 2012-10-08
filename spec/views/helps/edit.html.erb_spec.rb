require 'spec_helper'

describe "helps/edit.html.erb" do
  before(:each) do
    @help = assign(:help, stub_model(Help))
  end

  it "renders the edit help form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => helps_path(@help), :method => "post" do
    end
  end
end
