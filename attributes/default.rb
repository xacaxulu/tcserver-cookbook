#
# Cookbook Name:: tcserver
# Attributes:: default
#
# Copyright (C) 2014 Charles Johnson <charles@getchef.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
default['tcserver']['tarball'] = 'vfabric-tc-server-standard-2.9.8.RELEASE.tar.gz'
default['tcserver']['tarball_url'] = "https://s3.amazonaws.com/bbt-chef/#{node[:tcserver][:tarball]}"
