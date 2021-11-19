Rails.application.routes.draw do
  get 'home/index'
  get 'homepage/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do 
    namespace 'v1' do 
      resources(:articles)
    end
  end
end