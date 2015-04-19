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
# == Class: mailman::config
#
# Class to configure properly the mailman
#
class mailman::config {

  maillist { 'mailman' :
    ensure   => $mailman::ensure,
    admin    => $mailman::admin_email,
    password => sha1($mailman::password),
  }

  $sha1_password = sha1($mailman::password)
  file { '/etc/mailman/adm.pw' :
    ensure  => file,
    group   => 'mailman',
    content => "${sha1_password}\n",
  }

  if $mailman::settings {
    file { $mailman::config_file :
      ensure  => file,
      content => template('mailman/mm_cfg.py.erb'),
      group   => 'mailman',
    }
  }

  if $mailman::manage_vhost_file {
    case $mailman::vhost_provider {
      default: { include ::mailman::vhost::httpd }
    }
  }

}
