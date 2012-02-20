#
# Author:: Grant Means (<grant@defiantbyte.com>)
# Copyright:: Copyright (c) 2011 Defiant Byte
# License:: Apache License, Version 2.0
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
#
require 'chef/knife/rackspace_base'

class Chef
  class Knife
    class RackspaceZoneList < Knife

      include Knife::RackspaceBase

      banner "knife rackspace zone list (options)"

      def run
        zone_list = [ 
          ui.color('ID', :bold),
          ui.color('Name', :bold),
          ui.color('Comment', :bold),
          ui.color('AccountId', :bold),
          ui.color('TTL', :bold),
          ui.color('EmailAddress', :bold)
        ]
        connection.zones.sort_by(&:id).each do |zone|
          zone_list << zone.id.to_s
          zone_list << zone.name
          zone_list << zone.comment
          zone_list << zone.accountId.to_s
          zone_list << zone.ttl
          zone_list << zone.emailAddress
        end
        puts ui.list(zone_list, :columns_across, 6)
      end
    end
  end
end