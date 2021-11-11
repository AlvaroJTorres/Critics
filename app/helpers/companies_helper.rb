module CompaniesHelper
  def format_description(description)
    return '' unless description
    return description if description.size <= 80

    "#{description[0..80]}..."
  end
end
