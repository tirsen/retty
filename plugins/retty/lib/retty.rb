module Retty
  def jar_files
    standalone_jar_files.reject{|j| j =~ /jruby-complete/ }
  end
  module_function :jar_files
  
  def standalone_jar_files
    retty_jar_files + user_jar_files
  end
  module_function :standalone_jar_files
  
  def retty_jar_files
    Dir[File.join(RAILS_ROOT, 'vendor', 'plugins', 'retty', 'lib', '*.jar')]
  end
  module_function :retty_jar_files
  
  def user_jar_files
    Dir[File.join(RAILS_ROOT, 'vendor', 'java', '*.jar')]
  end
  module_function :user_jar_files
end
