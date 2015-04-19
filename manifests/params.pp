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
# == Class: mailman::params
#
# Class that list mailman default params
#
class mailman::params {

  $ensure            = 'present'
  $package_ensure    = 'installed'
  $package_name      = 'mailman'
  $service_ensure    = 'running'
  $service_name      = 'mailman'
  $service_enable    = true
  $config_file       = '/etc/mailman/mm_cfg.py'
  $manage_vhost_file = false
  $vhost_provider    = 'httpd'

}
