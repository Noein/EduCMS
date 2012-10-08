require 'spec_helper'

describe "grades/new.html.erb" do
  before(:each) do
    assign(:grade, stub_model(Grade,
      :user_id => 1,
      :survey_id => 1,
      :mark => 1,
      :percentage => 1.5,
      :right => 1
    ).as_new_record)
  end

  it "renders new grade form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => grades_path, :method => "post" do
      assert_select "input#grade_user_id", :name => "grade[user_id]"
      assert_select "input#grade_survey_id", :name => "grade[survey_id]"
      assert_select "input#grade_mark", :name => "grade[mark]"
      assert_select "input#grade_percentage", :name => "grade[percentage]"
      assert_select "input#grade_right", :name => "grade[right]"
    end
  end
end
