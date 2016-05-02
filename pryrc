# Utilities
module Enumerable
  def group_count
    counts = {}
    self.each do |i|
      group = yield(i)
      counts[group] = (counts[group] || 0) + 1
    end
    counts
  end
end
