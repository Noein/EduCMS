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

EduCMS::Application.routes.draw do

  resources :grades

  resources :surveys

  resources :messages

  resources :documents

  resources :subjects

  resources :categories

  resources :groups

  resources :news

  resources :password_resets

  resources :user_sessions

  resources :users do
    member do
      get :activate
    end
  end

  # /surveys/1/testing
  resources :surveys do
    member do
      get :testing
    end
  end

#-----Grades---------------------------------------------------------------

  # /users/1/grades
  resources :users do
    member do
      get :grades
    end
  end

  # /surveys/1/grades
  resources :surveys do
    member do
      get :grades
    end
  end

   # /subjects/1/grades
  resources :subjects do
    member do
      get :grades
    end
  end

   # /groups/1/grades
  resources :groups do
    member do
      get :grades
    end
  end

  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"
  get "user_sessions/new"
  get "user_sessions/create"
  get "user_sessions/destroy"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  match '/about'                  => 'home#about'
  match '/contacts'               => 'home#contacts'
  match '/index'                  => 'news#index'
  match '/signup'                 => 'users#new'
  match '/learn'                  => 'documents#index'
  match '/help'                   => 'help#index'
  match '/help/markup'            => 'help#markup'
  match '/help/administration'    => 'help#administration'
  match '/admin'                  => 'admin#index'
  match '/admin/criteria'         => 'admin#criteria'
  match 'internal_server_error'   => 'errors#internal_server_error'
  match 'not_found'               => 'errors#not_found'
  match 'unprocessable_entity'    => 'errors#unprocessable_entity'

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
  match 'login'   => 'user_sessions#new',     :as => :login
  match 'logout'  => 'user_sessions#destroy', :as => :logout
  match 'inbox'   => 'messages#inbox',        :as => :inbox
  match 'outbox'  => 'messages#outbox',       :as => :outbox

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => "news#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
