require_relative "02a_link"

# A SentinelLink class helps us manage a list. A linked list will
# always include at least two links: the first and last
# sentinels. They're dummy objects.
class SentinelLink < Link
  def initialize
    super(nil)
  end
end

class LinkedList
  def initialize
    @first_sentinel = SentinelLink.new
    @last_sentinel = SentinelLink.new
    @first_sentinel.insert_right(@last_sentinel)
  end

  def push_link(link)
    @last_sentinel.insert_left(link)
  end

  def push(value)
    link = Link.new(value)
    push_link(link)

    link
  end

  def pop_link
    raise "Can't pop from an empty list!" if empty?
    popped = @last_sentinel.prev
    popped.remove

    popped
  end

  def pop
    pop_link.value
  end

  def unshift_link(link)
    @first_sentinel.insert_right(link)
  end

  def unshift(value)
    unshift_link(Link.new(value))
  end

  def shift_link
    raise "Can't shift from an empty list!" if empty?
    shifted = @first_sentinel.next
    shifted.remove

    shifted
  end

  def shift
    shift_link.value
  end

  def [](index)
    raise "index out of bounds" if index < 0
    link = @first_sentinel
    position = -1
    until position == index
      link = link.next
      raise "index out of bounds" if link.value == nil
      position += 1
    end

    link
  end

  def empty?
    @first_sentinel.next == @last_sentinel
  end
end
