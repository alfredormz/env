%w{rubygems wirble irb/completion irb/ext/save-history }.each do |lib|
  begin
    require lib
  rescue LoadError => err
    $stderr.puts "Couldn't load #{lib}: #{err}"
  end
end

IRB.conf[:SAVE_HISTORY] = 100
#IRB.conf[:HISTORY_FILE] = "#{ENV["HOME"]}/.irb-history"
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:PROMPT_MODE] = :SIMPLE

Wirble.init
Wirble.colorize

alias q exit
