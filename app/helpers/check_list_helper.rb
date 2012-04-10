module CheckListHelper
  
  def link_to_problem check_item_id
    result = Result.find_by_check_item_id_and_completed_on(check_item_id, nil)

    if result && result.severity > 0
      result.comment.nil? ? problem = "#{define_severity(result.severity)} problem reported" : problem = result.comment[0..50]
      problem += '...' if problem != result.comment && !result.comment.nil?
      link_to problem, edit_result_path(:id => result.id)
    elsif result && result.severity == 0
      link_to "Marked OK #{time_ago_in_words(result.updated_at)} ago", edit_result_path(:id => result.id)
    else
      link_to "Report Problem", new_result_path(:check_item_id => check_item_id)
    end   
  end
  
    
  def disable_checkbox check_item_id
    result = Result.find_by_check_item_id_and_completed_on(check_item_id, nil)    
    result && result.severity > 0 ? true : false
  end
    
end
