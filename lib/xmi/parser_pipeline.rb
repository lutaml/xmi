# frozen_string_literal: true

module Xmi
  # Composable pipeline for XMI parsing.
  #
  # Each step receives a context hash and returns an updated context hash.
  # New concerns (validation, logging, caching) are added by inserting steps
  # without modifying existing code — Open/Closed Principle.
  #
  # @example
  #   context = { xml: xml_content, root_class: Xmi::Sparx::SparxRoot }
  #   result = Xmi::ParserPipeline.run(context)
  #   result[:root]  # => parsed SparxRoot instance
  #
  module ParserPipeline
    module Steps
      module FixEncoding
        def self.call(ctx)
          xml = ctx[:xml]
          if xml.respond_to?(:valid_encoding?) && !xml.valid_encoding?
            xml = xml
              .encode("UTF-16be", invalid: :replace, replace: "?")
              .encode("UTF-8")
          end
          ctx.merge(xml: xml)
        end
      end

      module InitVersioning
        def self.call(ctx)
          Xmi.init_versioning!
          ctx
        end
      end

      module ParseXml
        def self.call(ctx)
          root_class = ctx[:root_class]
          root = VersionRegistry.parse_with_detected_version(ctx[:xml], root_class)
          ctx.merge(root: root)
        end
      end

      module BuildIndex
        def self.call(ctx)
          root = ctx[:root]
          root.build_index if root.respond_to?(:build_index)
          ctx
        end
      end
    end

    DEFAULT_STEPS = [
      Steps::FixEncoding,
      Steps::InitVersioning,
      Steps::ParseXml,
      Steps::BuildIndex,
    ].freeze

    # Run the pipeline with default or custom steps.
    #
    # @param ctx [Hash] Initial context with :xml and :root_class
    # @param steps [Array<Module>] Pipeline steps (defaults to DEFAULT_STEPS)
    # @return [Hash] Final context including :root
    def self.run(ctx, steps: DEFAULT_STEPS)
      steps.reduce(ctx) { |context, step| step.call(context) }
    end
  end
end
