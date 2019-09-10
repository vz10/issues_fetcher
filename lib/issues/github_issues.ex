defmodule Issues.GitHubIssues do
    @user_agent [{"User-agent", "Elixirfuck@fuck.com"}]

    def fetch(user, project) do
        issues_url(user, project)
        |> HTTPoison.get(@user_agent)
        |> handle_response
    end

    def issues_url(user, project) do
        "#{Application.fetch_env!(:issues, :git_hub)}#{user}/#{project}/issues"
    end

    def handle_response({_, %{status_code: status_code, body: body}}) do
        {
            status_code |> check_for_error,
            body |> parser
        }
    end

    def parser(body) do
        {:ok, result} = Poison.Parser.parse(body)
        result
    end

    def check_for_error(200), do: :ok
    def check_for_error(_), do: :error

end