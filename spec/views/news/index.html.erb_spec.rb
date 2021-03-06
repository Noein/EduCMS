require 'spec_helper'

describe "news/index.html.erb" do
  before(:each) do
    assign(:news, [
      stub_model(News,
        :title => "Title",
        :content => "Content",
        :user_id => 1
      ),
      stub_model(News,
        :title => "Title",
        :content => "Content",
        :user_id => 1
      )
    ])
  end

  it "renders a list of news" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
