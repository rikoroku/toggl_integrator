# config: utf-8

require "optparse"

module TogglIntegrator

  class Command

    # Options to execute tasks for command line base
    # @author rikoroku
    module Options

      def self.parse! argv
        options = {}

        sub_command_parsers = create_sub_command_parsers
        command_parser      = create_command_parser

        begin
          command_parser.order! argv

          options[:options] = argv.shift

          sub_command_parsers[options[:command]].parse! argv

        rescue OptionParser::MissingArgument, OptionParser::InvalidOption, ArgumentError => e
          abort e.message
        end

        options
      end

      def self.create_sub_command_parsers
        sub_command_parsers = Hash.new do |k, v|
          rails ArgumentError, "'#{v}' is not toggl_integrator sub command."
        end

        sub_command_parsers["start"] = OptionParser.new do |opt|
          opt.on("-i VAL", "--interval=VAL", "Integration interval" ) { |v| options[:interval] = v }
        end

        sub_command_parsers["stop"] = OptionParser.new do |opt|
        end

        sub_command_parsers["status"] = OptionParser.new do |opt|
        end
      end

      def self.create_command_parser
        OptionParser.new do |opt|
          sub_command_help = [
            { name: "start -i interval", summary: "Start integrate" },
            { name: "stop",              summary: "Stop  integrate" },
            { name: "status",            summary: "Show  integrate status" },
          ]

          opt.banner = "Usage: #{opt.program_name} [-h|--help] [-v|--version] <command> [args]"
          opt.separator ""
          opt.separator "#{opt.program_name} Available Commands:"
          sub_command_help.each do |command|
            opt.separator [opt.summary_indent, command[:name].ljust(40), command[:summary]].join " "
          end

          opt.on_head("-h", "--help", "Show this message") do |v|
            puts opt.help
            exit
          end

          opt.on_head("-v", "--version", "Show program version") do |v|
            opt.version = TogglIntegrator::VERSION
            puts opt.ver
            exit
          end
        end
      end

      private_class_method :create_sub_command_parsers, :create_command_parser

    end
  end
end