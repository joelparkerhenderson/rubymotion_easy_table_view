# EasyTableView is a simple UITableView.
#
# This is suitable for displaying a plain table,
# with user interaction, a delegate and data source.
#
# Example to create its own delegate and data source:
#
#     table = EasyTableView.alloc.initMe(items: items)
#
# Example to use a custom delegate and data source:
#
#     books = ...
#     delegate = EasyTableViewDelegate.new(items: books)
#     source = EasyTableViewDataSource.new(items: books)
#     table = EasyTableView.alloc.initMe(delegate: delegate, source: books)
#
# @author Joel Parker Henderson (joel@joelparkerhenderson.com)
# @licence GPL  class EasyTableView < UITableView
#
class EasyTableView < UITableView
  C=name
  include SetAttrs

  def init
    super
    return self
  end

  def initMe(args = {})
    initWithFrame([[0,0],[0,0]], style:UITableViewStylePlain)
    set(args)
    self.userInteractionEnabled = args[:interaction] || true

    # Wire up the delegate and data source.
    #
    # If the caller didn't provide these, yet did provide items,
    # then we create a corresponding delegate and data source.
    #
    _items = args[:items]
    self.delegate = @delegate = (args[:delegate] || (_items ? delegate_class.new(items: _items) : nil))
    self.dataSource = @data_source = (args[:data_source] || (_items ? data_source_class.new(items: _items) : nil))
    self.autoresizingMask = (args[:autoresizing] || (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight))
    self
  end

  def delegate_class
    "#{self.class}Delegate".constantize
  end

  def data_source_class
    "#{self.class}DataSource".constantize
  end

end
