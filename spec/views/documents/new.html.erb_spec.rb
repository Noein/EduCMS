require 'spec_helper'

describe "documents/new.html.erb" do
  before(:each) do
    assign(:document, stub_model(Document,
      :path => "MyString",
      :title => "MyString",
      :descryption => "MyText",
      :type => 1,
      :category_id => 1,
      :group_id => 1,
      :subject_id => 1
    ).as_new_record)
  end

  it "renders new document form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => documents_path, :method => "post" do
      assert_select "input#document_path", :name => "document[path]"
      assert_select "input#document_title", :name => "document[title]"
      assert_select "textarea#document_descryption", :name => "document[descryption]"
      assert_select "input#document_type", :name => "document[type]"
      assert_select "input#document_category_id", :name => "document[category_id]"
      assert_select "input#document_group_id", :name => "document[group_id]"
      assert_select "input#document_subject_id", :name => "document[subject_id]"
    end
  end
end
