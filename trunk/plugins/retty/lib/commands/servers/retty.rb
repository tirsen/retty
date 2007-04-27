load File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', '..', '..', '..', 'config', 'environment.rb')) unless defined?(RAILS_ENV)
require 'java'

include_class 'org.mortbay.jetty.Server'
include_class 'org.mortbay.jetty.handler.ContextHandlerCollection'
include_class 'org.mortbay.jetty.webapp.WebAppContext'
include_class 'org.mortbay.jetty.servlet.ServletMapping'
include_class 'org.jruby.webapp.RailsServlet'
include_class 'org.jruby.webapp.FileServlet'

server = Server.new(3000)

webapp = WebAppContext.new(server, File.expand_path(RAILS_ROOT), "/")

webapp.initParams.put('jruby.standalone', 'false')
webapp.initParams.put('rails.env', RAILS_ENV)
webapp.initParams.put('files.default', 'rails')

rails = webapp.servletHandler.newServletHolder(RailsServlet)
rails.name = 'rails'
webapp.servletHandler.addServlet(rails)

files = webapp.servletHandler.newServletHolder(FileServlet)
files.name = 'files'
webapp.servletHandler.addServlet(files)

# need to start before adding the '/' mapping or the defaults will overwrite it
server.start

mapping = ServletMapping.new
mapping.pathSpecs = ['/'].to_java('java.lang.String')
mapping.servletName = 'files'
webapp.servletHandler.addServletMapping(mapping)

server.join
