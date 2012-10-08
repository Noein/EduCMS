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

class Survey < ActiveRecord::Base
  belongs_to :group
  belongs_to :subject
  has_many :grades, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  def estimate(hash, user_id)
    answers = {}
    error = false
    correct = 0
    persent = 0
    mark = 0
    questions_count = questions.size

    # answers: { "question_id" => [ "answer_id", "answer_id" ] }, for exmpl: {"5"=>["11", "13"]}
    hash.each_key do |key|
      unless answers[ key[/\d+/] ]
        answers[ key[/\d+/] ] = [ key[/_\d+/].sub("_", "") ]
      else
        answers[ key[/\d+/] ] = answers[ key[/\d+/] ] + [ key[/_\d+/].sub("_", "") ]
      end
    end

    answers.each_key do |question_id|
      real_answers = Question.find_by_id( question_id ).answers.where( :checked => true )
      if real_answers.size == answers[ question_id ].size then
        real_answers.each do |x|
          unless answers[ question_id ].include?( x.id.to_s ) then
            error = true
            break
          end
        end
        unless error
          correct += 1
        else
          error = false
        end
      end
    end

    persent = 100 * correct / questions_count

    case persent
    when 90..100
      mark = 5
    when 75..90
      mark = 4
    when 60..75
      mark = 3
    else
      mark = 2
    end

    return Grade.create(:user_id => user_id, :survey_id => id, :mark => mark, :percentage => persent.to_f, :questions => questions_count, :right => correct)
  end

end
