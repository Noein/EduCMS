require 'spec_helper'

describe "surveys/edit.html.erb" do
  before(:each) do
    @survey = assign(:survey, stub_model(Survey,
      :group_id => 1,
      :subject_id => 1,
      :title => "MyString",
      :descryption => "MyText"
    ))
  end

  it "renders the edit survey form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => surveys_path(@survey), :method => "post" do
      assert_select "input#survey_group_id", :name => "survey[group_id]"
      assert_select "input#survey_subject_id", :name => "survey[subject_id]"
      assert_select "input#survey_title", :name => "survey[title]"
      assert_select "textarea#survey_descryption", :name => "survey[descryption]"
    end
  end
end
