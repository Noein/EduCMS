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

class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_users_list

  if Rails.env.production?
    rescue_from ActionController::RoutingError,     :with => :render_404
    rescue_from ActionController::UnknownAction,    :with => :render_404
    rescue_from ActionController::MethodNotAllowed, :with => :render_500
    rescue_from ActiveRecord::RecordNotFound,       :with => :render_404
    rescue_from ActiveRecord::RecordInvalid,        :with => :render_500
    rescue_from ActiveRecord::StatementInvalid,     :with => :render_500
    rescue_from ActionView::Template::Error,        :with => :render_500
    rescue_from NoMethodError,                      :with => :render_500
    rescue_from AbstractController::ActionNotFound, :with => :render_500

    def render_404
      if /(doc?x|pdf|odf)/i === request.path
        render :text => "404 Not Found", :status => 404
      else
        render :template => 'errors/not_found', :status => 404
      end
    end

    def render_500
      render :template => 'errors/internal_server_error', :status => 500
    end

    def local_request?
      false
    end
  end

  protected

  class ActiveSupport::TimeWithZone
    def to_s(format = :default)
      if self.year == Time.now.year
        I18n.l(self.in_time_zone('Moscow'))
      else
        I18n.l(self.in_time_zone('Moscow'), :format => :with_year)
      end
    end
  end

  def admin?
    if current_user
      unless current_user.admin == true
        flash[:notice] = "Только аминистратор может просматривать эту страницу"
        redirect_to login_path
      end
    else
      flash[:notice] = "Для доступа к этой странице необходимо зайти в свой аккаунт"
      redirect_to login_path
    end
  end

  def this_user?
    if current_user
    else
      flash[:notice] = "Для доступа к этой странице необходимо зайти в свой аккаунт"
      redirect_to login_path
    end
  end

  def not_authenticated
    redirect_to login_path, :alert => "Пожалуйста, зайдите в свой аккаунт."
  end

  def current_users_list
    current_users
  end

end
