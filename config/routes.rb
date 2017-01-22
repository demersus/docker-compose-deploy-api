Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  get '/services/:id/logs' => 'services#logs'

  [:deploy, :start, :stop].each do |cmd|
    post "/services/:id/#{cmd}" => "services##{cmd}"
  end
end
