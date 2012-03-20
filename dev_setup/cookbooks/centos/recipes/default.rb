
require_recipe 'centos::start_stop_daemon'

package "git"

bash "Update RubyGems to 1.8.x" do
  code %{
    gem update --system
  }
  not_if { `gem --version` =~ /^1\.8\./ }
end

# FIXME: These steps may be specific to the particular CentOS 6.2
# image we're using
bash "Move rubygems to /usr/lib64/ruby" do
  code %{
    mv /usr/lib{,64}/ruby/gems
    # Make sure all gems are pristine
    gem pristine --all
  }
  not_if { File.directory? "/usr/lib64/ruby/gems/1.8" }
end

ruby_block "Fix gemspecs with invalid date formats" do
  block do
    `gem --version 2>&1`.lines.each do |l|
      if l =~ /Invalid gemspec in \[([^\]]+)\]: invalid date format/
        gemspec = $1
        gemspec_contents = IO.readlines(gemspec)
        File.open(gemspec, 'w') do |f|
          gemspec_contents.each do |l|
            f << l.sub(/ 00:00:00.000000000Z/, '')
          end
        end
      end
    end
  end
end

gem_package "rake"
