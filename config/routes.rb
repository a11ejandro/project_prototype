Rails.application.routes.draw do
  root to: 'api/v1/doc#index'

  namespace :api do
    namespace :v1, defaults: {format: 'json'} do
      namespace :admin do
        resources :users, only: [:index, :show, :update, :destroy] do
          member do
            post :reset_password
          end
        end

        resources :sessions, only: [] do
          collection do
            post :sign_in
            post :sign_out
          end
        end
      end

      resources :users, only: [:show, :update] do
        collection do
          post :update_password
          post :reset_password
        end
      end

      resources :sessions, only: [] do
        collection do
          post :sign_up
          post :sign_in
          post :sign_out
        end
      end

      resources :doc, only: [:index], defaults: {format: 'html'} do
        collection do
          get :sign_in
          post :new_session
          delete :delete_session
        end
      end
    end
  end
end
