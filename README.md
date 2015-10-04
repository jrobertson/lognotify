# Introducing the lognotify gem

In an effort to pay more attention to log files I wrote the lognotify gem to make it convenient to monitor a log file's recent entries.

    require 'lognotify'


    ln = LogNotify.new('/tmp/mail.info')

    def ln.on_update(entry)

      puts 'entry: ' + entry.inspect

      if entry =~ /citserver\[1988\]: Context: <james> logged in/ then
        puts 'James logged into the mail server'
      end
      
    end

    ln.start

In the above example the lognotify gem monitors the updates to the file */tmp/mail.info* and prints out the most recent log entry. It checks if James as logged into the mail server and if he has it prints out the following message:

<pre>James logged into the mail server</pre>

Show below is the code used to create a sample log file while lognotify was running:

    require 'logger'

    log = Logger.new '/tmp/mail.info'
    log.info 'testing'
    sleep 2
    log.info 'box1 citserver[1988]: Context: <james> logged in'
    sleep 1
    log.info 'new mail arrived'
    log.close

Output:

<pre>
entry: "I, [2015-10-04T10:26:38.444514 #5675]  INFO -- : testing\n"
entry: "I, [2015-10-04T10:26:40.446443 #5675]  INFO -- : box1 citserver[1988]: Context: <james> logged in\n"
James logged into the mail server
entry: "I, [2015-10-04T10:26:41.447813 #5675]  INFO -- : new mail arrived\n"
</pre>

## Resources

* lognotify https://rubygems.org/gems/lognotify

lognotify gem log monitor
