# EasyTableViewDelegate is a simple UITableViewDelegate.
#
# This is suitable for displaying a list of items,
# and letting the user select any of the items.
#
# The cell style defaults to subtitle.
#
# Example:
#
#    books = ...
#    delegate = EasyTableViewDelegate.new(items: books)
#
# @author Joel Parker Henderson (joel@joelparkerhenderson.com)
# @licence GPL
#
class EasyTableViewDelegate
  include SetAttrs

  attr_accessor :items

  def initialize(args = {})
    set(args)
  end

  #-----------------------------------------------------------------------
  # UITableViewDelegate protocol optional methods
  #-----------------------------------------------------------------------

  def tableView(tableView, willSelectRowAtIndexPath:indexPath)
    item = items[indexPath.row]
    tableView(tableView, willSelectItem: item)
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    item = items[indexPath.row]
    tableView(tableView, didSelectItem: item)
  end

  #-----------------------------------------------------------------------
  # Custom optional methods
  #-----------------------------------------------------------------------

  def tableView(tableView, willSelectItem:item)
    #noop
  end

  def tableView(tableView, didSelectItem:item)
    #noop
  end

end
