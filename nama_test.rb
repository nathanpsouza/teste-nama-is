require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require './lib/replacer'

replacer = Replacer.new([*1..100])

replacer.replace_multiples(5, "Nama")
replacer.replace_multiples(7, "Team")
replacer.replace_multiples(35, "Nama Team")

puts replacer.result.join(", ")