# coding: utf-8

# Copyright (C) 2011-2012 Vladislav Mileshkin
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

class SurveysController < ApplicationController

  before_filter :admin?, :only => [:edit, :new, :create, :update, :destroy]

  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.paginate(:page => params[:page])
    @title = "Тесты"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @surveys }
    end
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
    @survey = Survey.find(params[:id])
    @title = @survey.title

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @survey }
    end
  end

  def testing
    @survey = Survey.find(params[:id])
    @title = @survey.title

    if params[:utf8] then
      result = @survey.estimate( params.select { |k,v| k =~ /\d+_\d+/ }, current_user.id )
      respond_to do |format|
        format.html { redirect_to grades_user_path(current_user) }
        format.json { render json: @survey }
      end
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @survey }
      end
    end

  end

  # GET /surveys/new
  # GET /surveys/new.json
  def new
    @survey = Survey.new
    @title = "Новый тест"

    3.times do
      question = @survey.questions.build
      4.times { question.answers.build }
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @survey }
    end
  end

  # GET /surveys/1/edit
  def edit
    @survey = Survey.find(params[:id])
    @title = @survey.title
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(params[:survey])

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: 'Тест добавлен.' }
        format.json { render json: @survey, status: :created, location: @survey }
      else
        format.html { render action: "new" }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /surveys/1
  # PUT /surveys/1.json
  def update
    @survey = Survey.find(params[:id])

    respond_to do |format|
      if @survey.update_attributes(params[:survey])
        format.html { redirect_to @survey, notice: 'Тест обновлён.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy

    respond_to do |format|
      format.html { redirect_to surveys_url }
      format.json { head :ok }
    end
  end

  def grades
    @grades = Survey.find(params[:id]).grades
    @title = "Оценки"
    respond_to do |format|
      format.html
      format.json { render json: @grades }
    end
  end

end
