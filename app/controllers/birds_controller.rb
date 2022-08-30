class BirdsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :error_message

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = find_bird
    render json: bird
  end

  # PATCH /birds/:id
  def update
    bird = find_bird
    bird.update(bird_params)
    render json: bird
  end

  # PATCH /birds/:id/like
  def increment_likes
    bird = find_bird
    bird.update(likes: bird.likes + 1)
    render json: bird
  end

  # DELETE /birds/:id
  def destroy
    bird = find_bird
    bird.destroy
    head :no_content
  end

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end

  def error_message
    render json: { error: 'bird not found' }, status: :not_found
  end

  def find_bird
    # Bird.find_by(id: params[:id])
    Bird.find(params[:id])

  end

end
