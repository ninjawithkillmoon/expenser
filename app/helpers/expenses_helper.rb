module ExpensesHelper
  def default_pill
    'month'
  end

  # Returns 'active' if the current nav param value matches this pill.
  #
  # Returns 'active' if the current nav param value is empty and pill_name is equal to default_pill.
  #
  # Return empty string otherwise.
  #
  # * *Args*    :
  #   - ++ -> 
  # * *Returns* :
  #   - 
  #
  def navbar_active_pill(pill_name)
    unless params[:nav].nil?
      if params[:nav].casecmp(pill_name) == 0
        return 'active'
      end
    else
      if pill_name.casecmp(default_pill) == 0
        return 'active'
      end
    end

    return ''
  end
end