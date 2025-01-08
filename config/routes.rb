Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "homes#index"

  resources :students
  resources :teachers
  resources :reports do
    collection do
      get   :step_one
      post  :step_one_submit
      get   :step_two
    end
  end
  resources :classroom_sessions do
    collection do
      get   :ziyadahVerses_by_surah
      get   :murajaahVerses_by_surah
      get   :students_by_year_and_semester
      get   :step_one
      post  :step_one_submit
      get   :step_two
      post  :step_two_submit
      get   :edit_sessions
      get   :students_edit
    end
  end
  resources :classroom_students do
    collection do
      get   :students_by_classroom
      get   :edit_classroom
      get   :students_by_class_year_semester
    end
  end
end
