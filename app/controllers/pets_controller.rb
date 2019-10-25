class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    
    #binding.pry  
    @pet = Pet.create(params[:pet])
  if !params["owner"]["name"].empty?
    @owner = Owner.new
    @owner.name = params["owner"]["name"]
    @owner.save
    @pet.owner = @owner
     @pet.save
    #binding.pry
  end
    
  redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  
  get '/pets/:id/edit' do 
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end
  
  patch '/pets/:id' do 
  
    @pet = Pet.find_by_id(params[:id])
    @pet.name = params['pet'][:name]
    if Owner.find_by(name: params['owner'][:name])
      @pet.owner= Owner.find_by(name: params['owner'][:name])
    else 
      @owner = Owner.new
      @owner.name = params['owner'][:name]
      @owner.save
      @pet.owner= @owner 
      binding.pry
    end

    
    
    @pet.save
    
    redirect to "pets/#{@pet.id}"
  end


end