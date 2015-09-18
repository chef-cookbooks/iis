####################################################################################################
#
# Set IIS to allow or deny file extensions. If the extension is blocked, IIS will return 404.7 code
#
####################################################################################################

require 'chef/mixin/shell_out'
require 'rexml/document'

include Chef::Mixin::ShellOut
include REXML
include Opscode::IIS::Helper

action :config do
  ## Manage fileExtensions
  fileExtensions
end

def fileExtensions
  Chef::Log.debug("- new_resource.allowed_file_extensions: #{new_resource.allowed_file_extensions}")
  Chef::Log.debug("- new_resource.excluded_file_extensions: #{new_resource.excluded_file_extensions}")

  ## Get XML for requestFiltering elements
  cmd_current_values = "#{appcmd(node)} list config /section:system.webServer/security/requestFiltering /xml"
  cmd_current_values = shell_out(cmd_current_values)
  if cmd_current_values.stderr.empty?
    xml = cmd_current_values.stdout
    doc = Document.new(xml)
    fileExtensionContainer = IIS::RequestFiltering::FileExtensions::FileExtensionContainer.new(doc)
    cmdBuilder = IIS::RequestFiltering::FileExtensions::FileExtensionAppCommandBuilder.new(fileExtensionContainer, appcmd(node), new_resource.allowed_file_extensions, new_resource.excluded_file_extensions)
    cmd = cmdBuilder.build_command()

    if (cmd != nil)
      Chef::Log.debug("- #{cmd}")
      shell_out!(cmd)
    end
  end
end