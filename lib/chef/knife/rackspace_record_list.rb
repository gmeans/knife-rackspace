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
    class RackspaceRecordList < Knife

      include Knife::RackspaceBase

      banner "knife rackspace record list DOMAIN [domain]"

      def run
        
        all_zones = connection_dns.zones.sort_by(&:id)

        @name_args.each do |domain|
          all_zones.each do |zone|
            if zone.domain == domain
              record_list = [ 
                ui.color('ID', :bold),
                ui.color('Name', :bold),
                ui.color('Value', :bold),
                ui.color('TTL', :bold),
                ui.color('Type', :bold),
                ui.color('Priority', :bold)
              ]

              zone.records.sort_by(&:id).each do |record|
                record_list << record.id.to_s
                record_list << record.name.to_s
                record_list << record.value.to_s
                record_list << record.ttl.to_s
                record_list << record.type.to_s
                record_list << record.priority.to_s
              end
              puts ui.list(record_list, :columuns_across, 6)
            end
          end
        end
      end

    end
  end
end