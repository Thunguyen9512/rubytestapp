Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#signup'
  get 'home/index'
  get 'homepage/index'
  post 'authentication', to: "authentication#login"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do 
    namespace 'v1' do 
      resources(:authors)
      resources(:books)
      resources(:categories)
      resources(:publishers)
      resources(:users)
      resources(:orders)
    end
  end
end
