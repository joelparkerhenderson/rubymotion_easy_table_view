# EasyTableViewCell is a simple UITableViewCell.
#
# This is suitable for displaying an item,
# with an accessory disclosure indicator,
# and an image with scale aspect fit,
# and reusing the same cell for each item.
#
# The cell style defaults to subtitle.
#
# Example:
#
#    cell = EasyTableViewCell.alloc.init()
#
# @author Joel Parker Henderson (joel@joelparkerhenderson.com)
# @licence GPL
#
class EasyTableViewCell < UITableViewCell
  include SetAttrs

  def initWithStyle(style, reuseIdentifier: reuse_identifier)
    super
    initAfter
    self
  end

  def initAfter
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    self.imageView.contentMode = UIViewContentModeScaleAspectFit
  end

  def font_color
  end

  def background_color
  end

end
