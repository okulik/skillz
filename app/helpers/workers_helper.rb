module WorkersHelper
  def display_skills(skills, c = ',')
    skills.join(c)
  end

  def parse_skills(text)
    text.split(',')
  end
end