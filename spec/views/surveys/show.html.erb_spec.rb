require 'spec_helper'

describe "surveys/show.html.erb" do
  before(:each) do
    @survey = assign(:survey, stub_model(Survey,
      :group_id => 1,
      :subject_id => 1,
      :title => "Title",
      :descryption => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
