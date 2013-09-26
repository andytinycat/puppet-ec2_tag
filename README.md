# Puppet EC2 tag custom type

This module contains a custom type for managing tags on instances in EC2.

## Before you start

### Credentials

You must create an IAM user for Puppet to use - don't give Puppet your main AWS
keys as this is a fairly big risk to take.

Set the following IAM policy on the user to allow it to tag your instances:

    {
      "Statement": [
        {
          "Sid": "Stmt1363110345614",
          "Action": [
            "ec2:CreateTags",
            "ec2:DeleteTags",
            "ec2:DescribeTags"
          ],
          "Effect": "Allow",
          "Resource": [
            "*"
          ]
        }
      ]
    }

Edit `lib/puppet/provider/ec2_tag/aws.rb` and place your AWS access key and secret key in
the section at the bottom of the file.

### Required gems

You will need the `aws-sdk` gem installed in whatever Ruby your Puppet is running in.
I use [puppet-omnibus](https://github.com/andytinycat/puppet-omnibus) so this doesn't cause
me a great deal of trouble.

## Usage

The custom type is incredibly simple to use.

To create a tag:

    ec2_tag {"banana": value => "hello there"}

This will create a tag called "banana" and give it the value "hello there".

To delete a tag:

    ec2_tag {"banana": ensure => absent}

This will delete the tag "banana".
