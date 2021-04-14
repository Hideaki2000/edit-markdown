class Admin::ApplicationController < ApplicationController
  def access_token
    cookies[:access_token]|| false
  end
end