namespace :retty do
  desc "Starts Jetty for the current application"
  task :run_external => :environment do
    java_opts = []
    java_opts << "-classpath #{Retty.standalone_jar_files.join(classpath_separator)}"
    java_opts << "-Xmx512m"
    java_cmd = 'java'
    classname = 'org.jruby.Main'
    cmd = "#{java_cmd} #{java_opts.join(' ')} #{classname} #{scriptname}"
    puts cmd
    system cmd
  end

  desc "Starts Jetty for the current application"
  task :run => :environment do
    load(scriptname)
  end

  def classpath_separator
    ':'
  end

  def scriptname
    File.join(RAILS_ROOT, 'vendor', 'plugins', 'retty', 'lib', 'commands', 'servers', 'retty.rb')
  end
end
