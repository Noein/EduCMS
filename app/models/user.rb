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

class User < ActiveRecord::Base

  has_many :news, :dependent => :destroy
  has_many :grades, :dependent => :destroy
  belongs_to :group
  has_private_messages

  authenticates_with_sorcery!

  validates :username, :name, :surname, :email, :presence => { :message => "Не должно быть пустым" }
  validates :username, :email, :uniqueness => { :case_sensitive => false, :message => "Уже взято другим пользователем"}
  validates :username, :length => { :within => 3..15,  :too_short => "Должно составлять не менее %{count} символов",
    :too_long  => "Должно составлять не более %{count} символов" }
  validates :name, :surname, :presence => true, :length => { :maximum => 20, :too_long  => "Должно составлять не более %{count} символов" }
  validates :password, :confirmation => { :message => "Неверно введёно подтверждение пароля"},
      :presence => { :message => "Не должeн быть пустым" }, :on => :create
  validates :password, :length => { :within => 6..20, :too_short => "Должен составлять не менее %{count} символов",
    :too_long  => "Должно составлять не более %{count} символов" }, :on => :create
  validates :username, :format => { :with => /[a-z\-_]+/, :message => "Имеет недопустимый формат"}
  validates :email,    :format => { :with => /[\w\d.-]+@[\w\d.-]+\.[\w]{1,3}/, :message => "Имеет неверный формат"}
  validates :group_id, :presence => { :message => "Необходимо выбрать группу" }

  before_destroy :messages_destroy

#   HUMANIZED_ATTRIBUTES = {
#     :username => "Имя пользователя",
#     :name     => "Имя",
#     :surname  => "Фамилия",
#     :email    => "Электронная почта",
#     :password => "Пароль",
#     :group    => "Группа"
#   }
#
#   def self.human_attribute_name(attr, options={})
#     HUMANIZED_ATTRIBUTES[attr.to_sym] || super
#   end

  def messages_destroy
    (Message.where(:sender_id => self.id) + Message.where(:recipient_id => self.id)).each { |message| message.destroy }
  end

  def self.search(group, keywords)
    condition = Where.new
    unless keywords.blank?
      unless keywords.include? " "
        condition.and("username like ? OR name like ? OR surname like ?", "%#{keywords}%", "%#{keywords}%", "%#{keywords}%")
      else
        w = keywords.split(" ")
        condition.and("name like ? AND surname like ?", "%#{w.last}%", "%#{w.first}%")
      end
    end
    condition.and("group_id = ?", group) unless group.blank?
    unless condition.blank?
      where(condition.to_s).order('id DESC')
    else
      order('id DESC')
    end
  end

  ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    if instance.error_message.kind_of?(Array)
      html = ""
      instance.error_message.each do |string|
        html << "<li class='validation-error' style='color: red;'>#{string}</li>" unless string == "can't be blank" or string == "не может быть пустым"
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
