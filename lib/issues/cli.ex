defmodule Issues.CLI do

    @default_count 4

    @moduledoc """
    Fucking module documentation
    """

    def run(argv) do
        argv
        |> parse_args
        |> process
    end

    @doc """
    Awesome function for parsing CLI argumets
    """
    def parse_args(argv) do
        OptionParser.parse(
            argv, 
            switches: [help: :boolean], 
            aliases: [h: :help])
        |> elem(1)
        |> args_to_internal
    end
    
    def args_to_internal([user, project, count]) do
        [user, project, String.to_integer(count)]
    end

    def args_to_internal([user, project]) do
        [user, project, @default_count]
    end

    def args_to_internal(_) do
        :help
    end

    def process (:help) do
        IO.puts "Fuck you asshole, there is no help for you"
        System.halt(0)
    end

    def process ([project, user, count]) do
        Issues.GitHubIssues.fetch(project, user)
    end
    
end
