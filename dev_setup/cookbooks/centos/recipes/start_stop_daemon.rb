# http://blogfranz.blogspot.com/2009/01/start-stop-daemon-on-centosrhel5-and.html

package "perl-Module-Build"

bash "install po4a" do
  po4a_version = "0.34"
  po4a_url = "http://ftp.de.debian.org/debian/pool/main/p/po4a/po4a_#{po4a_version}.orig.tar.gz"
  cwd "/tmp"
  code %{
    curl -s -O -L #{po4a_url}
    tar zxf po4a_#{po4a_version}.orig.tar.gz
    cd po4a-#{po4a_version}
    make
    make install
  }
  not_if { File.executable?("/usr/local/bin/po4a") }
end

package "bzip2-devel"

bash "install start-stop-daemon" do
  dpkg_version = "1.14.31"
  dpkg_url = "http://ftp.de.debian.org/debian/pool/main/d/dpkg/dpkg_#{dpkg_version}.tar.gz"
  cwd "/tmp"
  code %{
    curl -s -O -L #{dpkg_url}
    tar zxf dpkg_#{dpkg_version}.tar.gz
    cd dpkg-#{dpkg_version}
    ./configure --with-bz2 --with-zlib --without-selinux
    make
    cp ./utils/start-stop-daemon /sbin
  }
  not_if { File.executable?("/sbin/start-stop-daemon") }
end
