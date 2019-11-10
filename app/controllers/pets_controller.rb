class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    @owner = Owner.create(params["owner_name"])
    @pet = Pet.create(owner: @owner)

    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner_name"].empty?
      @pet.owner = Owner.create(params[name: "owner_name"])
    end
    @pet.save
    redirect "pets/#{@pet.id}"


  get '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    @pet.save
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    if !params[:pet].keys.include?("owner_ids")
      params[:pet]["owner_ids"] = []
    end

    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owners << Owner.create(name: params["owner"]["name"])
    end
    redirect "owners/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    redirect '/pets/edit'
  end

end
