Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "admin/pages#dashboard"
  namespace :admin do
    resources :iso_docs
    resources :docs do
      member do
        get ":name/download", action: :download, as: :download
        get ":name/preview", action: :preview, as: :preview
        get ":name/share", action: :share, as: :share
        # get "preview"
        # get "share"
        get "replace"
        post "upgrade"
      end
    end
    resources :items do
      collection do
        post "upload"
        get "list"
      end
    end
    get "/employees/:id/items", to: "employee_items#index", as: "employee_items"
    get "/department/:id/items", to: "department_items#index", as: "department_items"
    resources :employees do
      collection do
        post "upload"
        get "list"
      end
    end
    resources :departments  
    namespace :finance do
      namespace :tickets do
        get "uploading"
        post "transform"
      end
    end
  end
end
