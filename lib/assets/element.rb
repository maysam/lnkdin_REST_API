class Element
  include Comparable

  attr_accessor :name, :priority

  def initialize(name, priority)
    @name, @priority = name, priority.to_i
  end

  def <=>(other)
    @priority <=> other.priority
  end
end
