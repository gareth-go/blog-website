class ReactionsController < ApplicationController
  before_action :set_post, only: %i[create update destroy]
  before_action :set_reaction, only: %i[update destroy]

  before_action :authenticate_user!

  def create
    if Reaction.reaction_types.include?(params[:reaction_type])
      @reaction = @post.reactions.build(user: current_user, reaction_type: params[:reaction_type])
    end

    if @reaction.save
      @reactions = Reaction.where(post: @post)
    else
      redirect_to @post
    end
  end

  def update
    if Reaction.reaction_types.include?(params[:reaction_type]) &&
       @reaction.update(reaction_type: params[:reaction_type])
      @reactions = Reaction.where(post_id: params[:post_id])
      @reaction = set_reaction
    else
      redirect_to @post
    end
  end

  def destroy
    @reaction.delete
    @reaction = nil

    @reactions = Reaction.where(post_id: params[:post_id])
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_reaction
    @reaction = Reaction.find(params[:id])
  end
end
