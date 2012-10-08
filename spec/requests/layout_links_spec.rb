# coding: utf-8
require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "index")
  end

  it "should have a Home page at '/'" do
    get '/index'
    response.should have_selector('title', :content => "index")
  end

  it "should have a Home page at '/'" do
    get '/about'
    response.should have_selector('title', :content => "about")
  end
  
end
