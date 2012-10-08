require 'spec_helper'

describe "grades/index.html.erb" do
  before(:each) do
    assign(:grades, [
      stub_model(Grade,
        :user_id => 1,
        :survey_id => 1,
        :mark => 1,
        :percentage => 1.5,
        :right => 1
      ),
      stub_model(Grade,
        :user_id => 1,
        :survey_id => 1,
        :mark => 1,
        :percentage => 1.5,
        :right => 1
      )
    ])
  end

  it "renders a list of grades" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
