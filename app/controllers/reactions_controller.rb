class ReactionsController < ApplicationController
  before_action :set_post, only: %i[create update destroy]
  before_action :set_reaction, only: %i[update destroy]

  before_action :authenticate_user!

  def create
    if Reaction.reaction_types.include?(params[:reaction_type])
      @reaction = @post.reactions.build(user: current_user, reaction_type: params[:reaction_type])
    else
      redirect_to @post
    end

    if @reaction.save
      set_reactions
    else
      redirect_to @post
    end
  end

  def update
    if Reaction.reaction_types.include?(params[:reaction_type]) &&
       @reaction.update(reaction_type: params[:reaction_type])
      set_reactions
    else
      redirect_to @post
    end
  end

  def destroy
    @reaction = @reaction.destroy.persisted?

    set_reactions
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_reaction
    @reaction = Reaction.find(params[:id])
  end

  def set_reactions
    @reactions = Reaction.where(post_id: params[:post_id])
  end
end
