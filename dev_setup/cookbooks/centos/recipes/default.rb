#
# These resources are prerequisites for running
# dev_setup/lib/chefsolo_launch.rb on CentOS.
#

require_recipe 'centos::start_stop_daemon'

package "git"

gem_package "rake"
