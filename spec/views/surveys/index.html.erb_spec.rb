require 'spec_helper'

describe "surveys/index.html.erb" do
  before(:each) do
    assign(:surveys, [
      stub_model(Survey,
        :group_id => 1,
        :subject_id => 1,
        :title => "Title",
        :descryption => "MyText"
      ),
      stub_model(Survey,
        :group_id => 1,
        :subject_id => 1,
        :title => "Title",
        :descryption => "MyText"
      )
    ])
  end

  it "renders a list of surveys" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
