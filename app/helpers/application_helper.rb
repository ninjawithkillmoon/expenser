module ApplicationHelper

  # Returns the full title for a page - eliminating the '|' if not required.
  #
  # Base title comes from Settings.title
  #
  # * *Args*    :
  #   - +p_titlePage+ -> The individual page's title.
  # * *Returns* :
  #   - The page title (if it exists) with the site base title appended to it. Separated by pipe character.
  #
  def fullTitle(p_titlePage)
    titleBase = Settings.title

    if(p_titlePage.empty?)
      return titleBase
    else
      return "#{p_titlePage} | #{titleBase}"
    end
  end

  def dtdd(p_dt, p_dd)
    return render 'layouts/components/dt_dd', dt: (p_dt.blank? ? raw("&nbsp;") : p_dt), dd: (p_dd.blank? ? raw("&nbsp;") : p_dd)
  end

  def avatar_url(user)
    default_url = "#{root_url}images/guest.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
  end

  # Returns 'active' if the current view's controller matches the input value.
  #
  # Return empty string otherwise
  #
  # * *Args*    :
  #   - ++ -> 
  # * *Returns* :
  #   - 
  #
  def sidebar_active_controller(controller_name)
    unless params[:controller].nil?
      if params[:controller].casecmp(controller_name) == 0
        return 'active'
      end
    end

    return ''
  end

  # Returns 'active' if the current view's action matches the input value.
  #
  # Return empty string otherwise
  #
  # * *Args*    :
  #   - ++ -> 
  # * *Returns* :
  #   - 
  #
  def sidebar_active_view(controller_name, action_name)
    if sidebar_active_controller(controller_name) == 'active'
      unless params[:action].nil?
        if params[:action].casecmp(action_name) == 0
          return 'active'
        end
      end
    end

    return ''
  end

  # Returns either a plus icon or a minus icon as HTML, depending
  # on the value of the input.
  #
  # * *Args*    :
  #   - ++ -> 
  # * *Returns* :
  #   - 
  #
  def plus_minus_html(number)
    if number >= 0.0
      return '<i class="icon-plus green"></i>'
    else
      return '<i class="icon-minus red"></i>'
    end
  end

  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def javascript_with_params(file)
    content_for(:head) { "<script src=\"#{file}\" type=\"text/javascript\"></script>".html_safe }
  end

  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files) }
  end
end
