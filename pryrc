# Utilities
module Enumerable
  def group_count
    counts = {}
    if block_given?
      self.each do |i|
        group = yield(i)
        counts[group] = (counts[group] || 0) + 1
      end
    else
      self.each do |i|
        group = i
        counts[group] = (counts[group] || 0) + 1
      end
    end

    counts
  end

  def group_sum
    sums = {}
    self.each do |i|
      group, amount = yield(i)
      sums[group] = (sums[group] || 0) + amount
    end
    sums
  end

  # g is for garrett, since I like it to return 0 for empty array
  def sum_g
    inject(0) do |sum, i|
      sum + (block_given? ? yield(i) : i)
    end
  end
end

def dump_to_file(array_of_strings, filename)
  File.open(filename, 'wb') do |f|
    array_of_strings.each do |s|
      raise 'contains non-string' if !s.is_a?(String)
      f.puts(s)
    end
  end
end

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'

  if defined?(PryCommands)
    Pry.commands.alias_command 's', 'sstep'
    Pry.commands.alias_command 'n', 'snext'
    Pry.commands.alias_command 'f', 'sfinish'
  else
    Pry.commands.alias_command 's', 'step'
    Pry.commands.alias_command 'n', 'next'
    Pry.commands.alias_command 'f', 'finish'
  end

  Pry.commands.alias_command 'b', 'break'
  Pry.commands.alias_command 'bda', 'break --disable-all'
end

if `hostname` =~ /st-garrett/
  # collects the results from all the pages of a list call via the Stripe
  # bindings
  #
  # example usage:
  #  bts = stripe_depaginate do |opts|
  #    Stripe::BalanceTransaction.all(opts.merge(transfer: 'tr_5817237asdf'))
  #  end
  def stripe_depaginate
    results = []
    page = yield({})
    results.concat(page.data)
    while page.has_more do
      sleep 0.1
      opts = {starting_after: page.data.last.id}
      puts "Fetching #{opts}"
      page = yield(opts)
      results.concat(page.data)
    end
    results
  end

  require 'stripe'
  Stripe.api_key = ENV['STRIPE_PROD_TEST_SECRET']
end
