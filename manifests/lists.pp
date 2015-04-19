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
# == Class: mailman::lists
#
# Class to create mailman lists
#
# == Parameters
#
#  [*lists*]
#    Hash of mailman list to create.
#    Look at Puppet maillist type reference for more details
#    Defaults to 'undef'
#
class mailman::lists (
  $lists = undef,
) {

  $lists_real = pick($lists, $mailman::lists, {})

  create_resources('maillist', $lists_real, {
    'ensure'   => 'present',
    'admin'    => $mailman::admin_email,
    'password' => sha1($mailman::password),
  })

}
