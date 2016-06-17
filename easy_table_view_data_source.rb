# EasyTableViewDataSource is a simple UITableViewDataSource.
#
# This is suitable for displaying a list of items,
# and reusing the same cell for each item.
#
# The cell style defaults to subtitle.
#
# Example:
#
#    source = EasyTableViewDataSource.new(items: items)
#
# @author Joel Parker Henderson (joel@joelparkerhenderson.com)
# @licence GPL
#
class EasyTableViewDataSource

  include SetAttrs

  attr_accessor :items

  def initialize(args = {})
    set(args)
  end

  #-----------------------------------------------------------------------
  # UITableViewDataSource required methods
  #-----------------------------------------------------------------------

  def tableView(tableView, numberOfRowsInSection:section)
    tableView or raise ArgumentError.new("tableView")
    section or raise ArgumentError.new("section")
    items or raise ArgumentError.new("items")
    return items.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    tableView or raise ArgumentError.new("tableView")
    indexPath or raise ArgumentError.new("indexPath")
    items or raise ArgumentError.new("items")

    row = indexPath.row
    row or raise "row"

    items or raise ArgumentError.new("items")
    item = items[indexPath.row]
    item or raise ArgumentError.new("item")

    cell = tableView.dequeueReusableCellWithIdentifier(reuse_identifier)
    cell or raise ArgumentError.new("cell not found with reuse_identifier:#{reuse_identifier}")
    cell ||= cell_alloc
    cell or raise ArgumentError.new("items")

    if item.respond_to?(:title) && (o = item.title) && (o.kind_of?(String))
      cell.textLabel.text = o
    end

    if item.respond_to?(:subtitle) && (o = item.subtitle) && (o.kind_of?(String))
      cell.detailTextLabel.text = o
    end

    if item.respond_to?(:table_view_cell_image) && (o = item.table_view_cell_image) && (o.kind_of?(UIImage))
      cell.image = o
    end

    if item.respond_to?(:table_view_cell_accessory) && (o = item.table_view_cell_accessory)
      cell.accessoryType = o
    end

    tableView(tableView, willDisplayCell:cell, forRowAtIndexPath:indexPath)

    return cell
  end

  #-----------------------------------------------------------------------
  # UITableViewDataSource optional methods
  #-----------------------------------------------------------------------

  def tableView(tableView, willDisplayCell:cell, forRowAtIndexPath:indexPath)
    tableView or raise ArgumentError.new("tableView")
    cell or raise ArgumentError.new("cell")
    indexPath or raise ArgumentError.new("indexPath")

    item = items[indexPath.row]

    if cell.respond_to?(:text_color) && cell.text_color
      cell.textLabel.textColor = cell.detailTextLabel.textColor = cell.text_color
    end

    if cell.respond_to?(:background_color) && cell.background_color
      cell.backgroundColor = cell.background_color
    end

  end

  #-----------------------------------------------------------------------
  # Helpers
  #-----------------------------------------------------------------------

  protected

  def cell_class
    "#{self.class}".sub(/DataSource$/,"Cell").constantize
  end

  def cell_alloc
    # Caution: do not memoize
    cell_class.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:reuse_identifier)
  end

  def reuse_identifier
    @reuse_identifier ||= BW.create_uuid.to_s
  end

end
