module ComponentsHelper
  def top_navigation_bar
    navbar(:light) { render 'shared/navbar' }
  end
end