# coding: utf-8
require 'spec_helper'

describe HomeController do
  render_views

  before(:each) do
    @base_title = "Какой-та сает | stepina.heroku.com"
  end
  
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
  
  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
  end

  it "should have the right title" do
    get 'about'
    response.should have_selector("title",
                                  :content => @base_title + " | about")
  end

  it "should have the right title" do
  get 'index'
  response.should have_selector("title",
                                :content => @base_title + " | index")
  end
  
end
