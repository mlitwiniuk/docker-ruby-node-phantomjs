require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir(".")

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
  end

  it "ubuntu" do
    expect(os_version).to include("Ubuntu 14")
  end

  # Libfontconfig is required at truntime for phantom
  %w{git}.each do |p|
    it "installs package #{p}" do
      expect(package(p)).to be_installed
    end
  end

  # PhantomJS runtime dependencies
  %w{fontconfig libjpeg8 libjpeg-turbo8 libicu52}.each do |p|
    it "installs package #{p}" do
      expect(package(p)).to be_installed
    end
  end

  describe command("ruby -v") do
    its(:stdout) { should match /2\.2\.3/ }
  end

  describe command("node -v") do
    its(:stdout) { should match /4\.2\.1/ }
  end

  describe command("npm -v") do
    its(:stdout) { should match /3\.3\.8/ }
  end

  describe command("phantomjs -v") do
    its(:stdout) { should match /2\.0\.0/ }
  end

  def os_version
    command("lsb_release -a").stdout
  end
end
