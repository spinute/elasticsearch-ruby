# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

module Elasticsearch
  module XPack
    module API
      module Watcher
        module Actions

          # Acknowledge watch actions to throttle their executions
          #
          # @option arguments [String] :watch_id Watch ID (*Required*)
          # @option arguments [List] :action_id A comma-separated list of the action ids to be acked (default: all)
          # @option arguments [Duration] :master_timeout Specify timeout for watch write operation
          #
          # @see http://www.elastic.co/guide/en/x-pack/current/watcher-api-ack-watch.html
          #
          def ack_watch(arguments={})
            raise ArgumentError, "Required argument 'watch_id' missing" unless arguments[:watch_id]
            arguments = arguments.clone
            watch_id  = arguments.delete(:watch_id)
            action_id  = arguments.delete(:action_id)

            method = Elasticsearch::API::HTTP_PUT

            path   = "_watcher/watch/#{watch_id}/_ack"
            path << "/#{action_id}" if action_id

            params = Elasticsearch::API::Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)
            body   = nil

            perform_request(method, path, params, body).body
          end

          # Register this action with its valid params when the module is loaded.
          #
          # @since 7.4.0
          ParamsRegistry.register(:ack_watch, [ :master_timeout ].freeze)
        end
      end
    end
  end
end
