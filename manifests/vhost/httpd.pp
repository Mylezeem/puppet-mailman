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
# == Class: mailman::vhost::httpd
#
# Class to configure the apache httpd vhost for the mailman
#
class mailman::vhost::httpd {

  if $mailman::vhost_configuration {
    create_resource('apache::vhost', $mailman::vhost_configuration)
  } else {
    apache::vhost { 'mailman' :
      docroot              => '/tmp',
      port                 => 80,
      servername           => $::fqdn,
      redirectmatch_status => [''],
      redirectmatch_regexp => ['^/mailman[/]*$'],
      redirectmatch_dest   => ["http://${::fqdn}/mailman/listinfo"],
      scriptaliases        => [
        {
          alias => '/mailman/',
          path  => '/usr/lib/mailman/cgi-bin/'
        },
      ],
      aliases              => [
        {
          alias => '/pipermail/',
          path  => '/var/lib/mailman/archives/public/'
        },
      ],
      directories          => [
        {
          'path'    => '/usr/lib/mailman/cgi-bin/',
          'options' => ['ExecCGI'],
        },
        {
          'path'    => '/var/lib/mailman/archives/public',
          'options' => ['MultiViews', 'FollowSymLinks'],
        },
      ],
    }
  }

}
