class Tag < ActiveRecord::Base
  attr_accessible :label_class, :name, :parent_id

  has_many :transactions

  belongs_to :parent, class_name: 'Tag', foreign_key: 'parent_id'

  has_many :children, class_name: 'Tag', foreign_key: 'parent_id'

  validates :name, presence: {value: :true}

  before_destroy :must_not_be_users_transfer_tag, :must_not_have_children, :must_not_have_transaction

  def must_not_be_users_transfer_tag
    if User.first.transfer_tag_id == id
      errors.add(:base, "Tag is the default tag for transfers")
      return false
    end
  end

  def must_not_have_children
    unless bottom?
      errors.add(:base, "Cannot delete tag with children")
      return false
    end
  end

  def must_not_have_transaction
    unless transactions.nil? || transactions.empty?
      errors.add(:base, "Cannot delete tag attached to any transactions")
      return false
    end
  end

  def top_level_id
    if root?
      return id
    else
      return parent.top_level_id
    end
  end

  def label_html
    "<span class=\"label label-large #{label_class}\">#{name}</span>"
  end

  def full_name
    full = name

    unless parent.nil?
      full = parent.full_name + ' - ' + full
    end

    return full
  end

  def top?
    return parent.nil?
  end

  def root?
    return top?
  end

  def bottom?
    return children.nil? || children.empty?
  end

  def leaf?
    return bottom?
  end

  def tree_javascript_keys
    keys = "['#{full_name}']"

    unless root?
      keys = parent.tree_javascript_keys + "[#{paramsKey}][#{childKey}]" + keys
    end

    return keys
  end

  def tree_javascript
    script = '';

    dataVar = 'tree_data'
    valueKey = "'#{full_name}'"
    nameKey = "'name'"
    typeKey = "'type'"

    if leaf?
      type = 'item'
    else
      type = 'folder'
    end

    # make variables
    script << "#{dataVar}#{tree_javascript_keys} = {};\r\n"
    script << "#{dataVar}#{tree_javascript_keys}[#{paramsKey}] = {};\r\n"
    script << "#{dataVar}#{tree_javascript_keys}[#{paramsKey}][#{childKey}] = {};\r\n"

    # values
    script << "#{dataVar}#{tree_javascript_keys}[#{nameKey}] = '#{label_html}';\r\n"
    script << "#{dataVar}#{tree_javascript_keys}[#{typeKey}] = '#{type}';\r\n"

    # recursive call
    unless leaf?
      children.each do |child|
        script << child.tree_javascript
      end
    end

    return script
  end

  private #-------------------------------------

  # tree javascript helpers
  def paramsKey
    "'additionalParameters'"
  end
  
  def childKey 
    "'children'"
  end
end
