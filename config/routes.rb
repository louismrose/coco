CocoTransform::Application.routes.draw do
  resources :transformations, only: [:show] do
    resources :instances, only: [:new, :create, :show]
    resources :errors, only: [:index]
  end
  
  get 'transformations/:id.gous' => 'transformations_for_gous#show', as: :transformation_for_gous
  
  post 'transformations/:transformation_id/instances.gous' => 'instances_for_gous#create', as: :new_transformation_instance_for_gous
  get 'transformations/:transformation_id/instances/:id.gous' => 'instances_for_gous#show', as: :transformation_instance_for_gous

  post 'transformations/:transformation_id/instances.batch.gous' => 'batch_instances_for_gous#create', as: :new_transformation_instances_for_gous
  
  mount Resque::Server, :at => "/resque"
  
  root 'transformations#index'
end
