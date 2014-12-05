Rails.application.routes.draw do
  root "pages#index"
  resources :users
  resources :projects do
    resources :tasks
    resources :memberships
  end

  post '/tasks/:task_id/create-comment' => 'tasks#create_comment', as: :task_comments

  get "about" => "pages#about", as: :about
  get "terms" => "pages#terms", as: :terms
  get "faq" => "pages#faq", as: :faq

  get '/sign-up' => 'registrations#new', as: :signup
  post '/sign-up' => 'registrations#create'
  get '/sign-in' => 'authentication#new', as: :signin
  post '/sign-in' => 'authentication#create'
  get '/sign-out' => 'authentication#destroy', as: :signout

  get '/seed_db' => 'public#seed_db', :as => 'seed_db'
end
