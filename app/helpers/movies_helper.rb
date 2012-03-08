module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def sortable(column, title = nil)
    title ||= column.titleize
    
    css_id = title + "_" + "header"
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {id: css_id }
  end
  def currently_sorted?(columnname)
  	return "hilite" if (params[:sort] and (params[:sort] == columnname))
  end
end
