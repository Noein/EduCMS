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

class Message < ActiveRecord::Base
  include ActiveModel::Validations

  is_private_message

  # The :to accessor is used by the scaffolding,
  # uncomment it if using it or you can remove it if not
  attr_accessor :to

  validates :to, :presence => { :message => "Не может быть пустым" }, :on => :create
  validates :subject, :length => { :maximum => 80, :too_long  => "Должена составлять не более %{count} символов" }, :on => :create
  validates_each :to, :on => :create do |record, attr, value|
    record.errors.add(attr, 'Такого пользователя не существует') if User.where(:username => value).blank?
  end

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

  self.per_page = 10
end
