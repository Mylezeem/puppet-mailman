#puppet-mailman

[![Build Status](https://api.travis-ci.org/Mylezeem/puppet-mailman.svg?branch=master)](https://travis-ci.org/Mylezeem/puppet-mailman)
[![License](http://img.shields.io/:license-apache-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.html)

##Overview

A puppet module that configures the Mailman mailing-list system

##Module Description

This module installs and configure the Mailman mailing-list system on an EL platform.
It handles :

 * package installation
 * mailman configuration
 * vhost creation (ie. for `/mailman`)
 * mailing-list creation

##Usage

This module requires only 2 mandatory parameters; the site wide password `$password` and the MLs admin email `$admin_email`

```puppet
class { '::mailman' :
  password    => 'asimplepassword',
  admin_email => 'admin@myml.org',
}
```

One can also create the mailing-lists at installation time

```puppet
class { '::mailman' :
  password    => 'asimplepassword',
  admin_email => 'admin@myml.org',
  lists       => { 'announce' => {}, 'dev' => {}},
}
```

##Parameters

####`password`
  The site wide password

####`admin_email`
  Email of the ML admin

####`ensure`
  Whether the mailman should be present on the system

####`package_ensure`
  Ensure state of the package

####`package_name`
  Name of the package

####`service_ensure`
  Ensure state of the service

####`service_name`
  Name of the service

####`service_enable`
  Whether to enable the service at boot

####`config_file`
  Path to the configuration file

####`manage_vhost_file`
  Whether to manage the vhost file

####`vhost_provider`
  Webserver running the vhost.

####`vhost_configuration`
  The vhost parameters passed to the resource.  Else a vhost is created by default.

####`lists`
  A list of mailing lists to create.  Please refer to Puppet maillist resource type to know the expected parameters here.

####`settings`
  Settings to override

##Limitations

This module works for :

* EL7
