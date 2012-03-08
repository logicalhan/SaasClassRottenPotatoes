module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def sortable(column, title = nil)
    title ||= column.titleize
    css_id = title + "_" + "header"
    if params[:direction]
      if params[:direction] == "asc"
        direction = "desc"
      else
        direction = "asc"
      end
    else
      direction = "asc"
    end
    link_to title.titleize, params.merge(:sort => column, :direction => direction, :page => nil), {id: css_id }
  end
  def currently_sorted?(columnname)
  	return "hilite" if (params[:sort] and (params[:sort] == columnname))
  end
end
