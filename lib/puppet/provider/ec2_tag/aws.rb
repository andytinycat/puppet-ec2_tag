require 'aws-sdk'
require 'yaml'

Puppet::Type.type(:ec2_tag).provide :aws do
  desc "Provider to set EC2 tags on AWS"

  def create
    ec2.instances[instance_id].tags[@resource[:name]] = @resource[:value]
  end

  def destroy
    ec2.instances[instance_id].tags.delete @resource[:name]
  end

  def exists?
    ec2.instances[instance_id].tags[@resource[:name]] != nil
  end

  def value
    ec2.instances[instance_id].tags[@resource[:name]]
  end

  def value=(tag_value)
    ec2.instances[instance_id].tags[@resource[:name]] = tag_value
  end

  def instance_id
    Facter['ec2_instance_id'].value
  end

  def ec2
    AWS::EC2.new(
      :access_key_id => "fill-me-in",
      :secret_access_key => "something-goes-here",
      :region => Facter['ec2_region'].value
    )
  end

end
