# 例
class CompanyPolicy < ::ApplicationPolicy
  def permitted_attributes
    %i[
      name
      president_name
      postcode
      address
    ]
  end

  def edit?
    user.admin? && user.company == company
  end

  def update?
    edit?
  end

  def show?
    user.company == company
  end
end
