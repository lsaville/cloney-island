class Api::V1::Projects::CommentsController < ActionController::API
  before_action :restrict_access

  def index
    project = Project.find_by_slug(params[:project])
    if project
      render json: project.comments
    else
      render json: {error: 'project not found'}, status: 404
    end
  end

  def create
    project = Project.find_by_slug(params[:project])
    user = User.find_by_api_key(params[:api_key])
    if project.backers.include?(user)
      comment = Comment.create(comment_body: params[:comment], user: user, project: project)
      render json: comment, status: 201
    else
      render json: {error: 'you are not backer of this project'}, status: 401
    end
  end

  private
    def restrict_access
      render json: {error: 'unauthorized'}, status: 401 unless User.find_by_api_key(params[:api_key])
    end
end
