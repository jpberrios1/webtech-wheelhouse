class Api::V1::BaseController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActionController::ParameterMissing, with: :render_bad_request

    private

    def require_api_token!
        is_valid_token = authenticate_with_http_token do |token, _options|
            expected_token = Rails.application.credentials.api_token
            ActiveSupport::SecurityUtils.secure_compare(token, expected_token)
        end

        unless is_valid_token
            render json: { errors: ["Invalid or missing token"] }, status: :unauthorized
        end
    end

    def render_not_found(exception)
        render json: {errors: ["Record not found"]}, status: :not_found
    end

    def render_bad_request(exception)
        render json: {errors: [exception.message]}, status: :bad_request
    end

end