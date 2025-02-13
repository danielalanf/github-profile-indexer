class UserQuery
  def initialize(param)
    @param = param
  end

  def search
    Elastic::UserSearchQuery.new(@param).search
  end
end
