#!/usr/bin/env ruby

# file: lognotify.rb

require 'sps-pub'


class LogNotify

  def initialize(logfile, sps_address: nil, sps_port: 59000, sps_topic: 'lognotify')

    @sps = sps_address ? SPSPub.new(address: sps_address, port: sps_port) : nil
    @sps_topic = sps_topic

    @command = 'tail -n 1 -F ' + logfile

  end
  
  def on_update(entry)
    
    # custom defined
    
  end

  def start()

    t = Time.now # using the time we can ignore existing entries

    IO.popen(@command).each_line do |x| 
      
      # anything after 5 seconds from start is new
      if Time.now > t + 5 then 
        
        raw_log_entry = x.lines.last
        
        #@sps.notice(@sps_topic + ': ' + json) if @sps
        on_update(raw_log_entry)
      end
    end

  end  
  
  def watch()

    return unless block_given?    
    
    t = Time.now # using the time we can ignore existing entries

    IO.popen(@command).each_line do |x| 
      
      # anything after 5 seconds from start is new
      if Time.now > t + 5 then 
        
        raw_log_entry = x.lines.last
        
        #@sps.notice(@sps_topic + ': ' + json) if @sps
        yield raw_log_entry
      end
    end

  end

end

if __FILE__ == $0 then
  
  ln = LogNotify.new('/var/log/messages')

  def ln.on_update(entry)

    puts 'entry: ' + entry.inspect
    
  end

  ln.start
  
end