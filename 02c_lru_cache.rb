require_relative "02b_linked_list"

class LRUCache
  attr_reader :hits, :misses

  def initialize(max_size, &prc)
    @linked_list = LinkedList.new
    @max_size = max_size
    @hits = 0
    @misses = 0
    @links_hash = {}
    @prc = prc
  end

  def [](key)
    if @links_hash.has_key?(key)
      link = @links_hash[key]
      link.remove
      @linked_list.push_link(link)

      @hits += 1

      return link.value
    end

    @misses += 1

    if @links_hash.count == @max_size
      link = @linked_list.shift_link
      @links_hash.delete(link.value)
    end

    value = @prc.call(key)

    @links_hash[key] = @linked_list.push(value)

    value
  end
end
