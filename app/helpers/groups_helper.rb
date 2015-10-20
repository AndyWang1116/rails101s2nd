module GroupsHelper
  def render_group_description(group)
    truncate(group.description, length: 55)
  end
end
