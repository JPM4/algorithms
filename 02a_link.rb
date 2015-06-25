# This is a basic link class.
class Link
  attr_reader :value, :next, :prev

  def initialize(value)
    @value = value
    @prev = nil
    @next = nil
  end

  def insert_left(link)
    link.next = self
    link.prev = @prev
    @prev.next = link if @prev
    @prev = link
  end

  def insert_right(link)
    link.prev = self
    link.next = @next
    @next.prev = link if @next
    @next = link
  end

  def remove
    if @prev && @next
      @prev.next = @next
      @next.prev = @prev
    elsif @prev
      @prev.next = nil
    elsif @next
      @next.prev = nil
    end
    @prev = nil
    @next = nil
  end

  def next=(link)
    @next = link
  end

  def prev=(link)
    @prev = link
  end

end
