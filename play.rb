require 'time'
require_relative 'game'
require_relative 'seed_reader'
STDOUT.sync = true

reader = SeedReader.new(ARGV[0])
control_file = ARGV[1]

def controls(control_file)
  controls = [0.2]
  if control_file
    controls = File.read(ARGV[1]).split(',').map {|control| control.chomp.to_f}
  else
  end
end

rows = reader.rows
cols = reader.cols
seed = reader.parse
game = Game.new(rows, cols, seed)
begin
  loop do
    print "\e[1;37m"
    print "generation: #{game.generation}   speed: #{controls(control_file)[0]}\n"
    print "\e[0;34m"
    game.each_row do |rows|
      rows.each do |cell|
        print " -- "
      end
      print "\n\r"
      rows.each do |cell|
        print "| "
        if cell.alive?
          print "\e[1;33m\u2740 "
        else
          print '  '
        end
        print "\e[;34m"
      end
      print "\n\r"
    end
    sleep controls(control_file)[0]
    print "\e[#{(rows*2)+1}A"
    ((rows*2) + 1).times do
      print "\e[K\n\r"
    end
    print "\e[#{(rows*2)+1}A\r"
    game.tick
  end
rescue Interrupt => exc
rescue SystemExit, SignalException
  raise
rescue Exception => exc
end
if exc
  puts "\r\e[1;37mBye!"
end
