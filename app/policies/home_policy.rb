HomePolicy = Struct.new(:user, :dashboard) do
  def index?
    user.present?
  end
end
