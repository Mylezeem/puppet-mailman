#  Copyright 2015 Yanis Guenane <yanis@guenane.org>
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
# == Class: mailman
#
# Setup mailman
#
# == Parameters
#
#  [*password*]
#    The site wide password
#
#  [*admin_email*]
#    Email of the ML admin
#
#  [*ensure*]
#    (Optional) Whether the mailman should be present on the system
#    Defaults to 'present'
#
#  [*package_ensure*]
#    (Optional) Ensure state of the package
#    Defaults to 'present'
#
#  [*package_name*]
#    (Optional) Name of the package
#    Defaults to 'mailman'
#
#  [*service_ensure*]
#    (Optional) Ensure state of the service
#    Defaults to 'running'
#
#  [*service_name*]
#    (Optional) Name of the service
#    Defaults to 'mailman'
#
#  [*service_enable*]
#    (Optional) Whether to enable the service at boot
#    Defaults to 'true'
#
#  [*config_file*]
#    (Optional) Path to the configuration file
#    Defaults to '/etc/mailman/mm_cfg.py'
#
#  [*manage_vhost_file*]
#    (Optional) Whether to manage the vhost file
#    Defaults to 'false'
#
#  [*vhost_provider*]
#    (Optional) Webserver running the vhost.
#    Defaults to 'httpd'
#
#  [*vhost_configuration*]
#    (Optional) The vhost parameters passed to the resource.
#               Else a vhost is created by default.
#    Defaults to 'undef'
#
#  [*lists*]
#    (Optional) A list of mailing lists to create.
#               Please refer to Puppet maillist resource type
#               to know the expected parameters here.
#    Defaults to '{}'
#
#  [*settings*]
#    (Optional) Settings to override
#    Defaults to '{}
class mailman (
  $password,
  $admin_email,
  $ensure              = $mailman::params::ensure,
  $package_ensure      = $mailman::params::package_ensure,
  $package_name        = $mailman::params::package_name,
  $service_ensure      = $mailman::params::service_ensure,
  $service_name        = $mailman::params::service_name,
  $service_enable      = $mailman::params::service_enable,
  $config_file         = $mailman::params::config_file,
  $manage_vhost_file   = $mailman::params::manage_vhost_file,
  $vhost_provider      = $mailman::params::vhost_provider,
  $vhost_configuration = undef,
  $lists               = {},
  $settings            = {},
) inherits mailman::params {


  if ($ensure == 'present' or $ensure == true) {
    anchor { 'mailman::start': }->
    class { '::mailman::install': }->
    class { '::mailman::config': }->
    class { '::mailman::service': }->
    class { '::mailman::lists' : }->
    anchor { 'mailman::end': }
  } else {
    anchor { 'mailman::start': }->
    class { '::mailman::service': }->
    class { '::mailman::config': }->
    class { '::mailman::install': }->
    anchor { 'mailman::end': }
  }

}
