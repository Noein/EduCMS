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

require 'where'

class Document < ActiveRecord::Base
  mount_uploader :file, FileUploader
  belongs_to :category
  belongs_to :group
  belongs_to :subject

  validates :title, :presence => { :message => "Не должно быть пустым" },
      :length => { :maximum => 150, :too_long  => "Должен составлять не более %{count} символов" }

  ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    if instance.error_message.kind_of?(Array)
      html = ""
      instance.error_message.each do |string|
        html << "<li class='validation-error' style='color: red;'>#{string}</li>" unless string == "can't be blank"
      end
      %(#{html_tag}<ul>
      #{html}</ul>).html_safe
    else
      %(#{html_tag}<span class="validation-error" style='color: red;'>
      #{instance.error_message}</span>).html_safe
    end
  end

  def self.search(category, subject, group, keywords)
    condition = Where.new
    condition.and('title like ? OR descryption like ?', "%#{keywords}%",  "%#{keywords}%") unless keywords.blank?
    condition.and('category_id = ?', category) unless category.blank?
    condition.and('group_id = ?', group) unless group.blank?
    condition.and('subject_id = ?', subject) unless subject.blank?
    unless condition.blank?
      where(condition.to_s).order('id DESC')
    else
      order('id DESC')
    end
  end

  self.per_page = 10
end
