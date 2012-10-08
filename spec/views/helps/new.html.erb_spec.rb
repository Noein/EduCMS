require 'spec_helper'

describe "helps/new.html.erb" do
  before(:each) do
    assign(:help, stub_model(Help).as_new_record)
  end

  it "renders new help form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => helps_path, :method => "post" do
    end
  end
end
