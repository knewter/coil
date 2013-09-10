defmodule Coil.ArchivesHandler do

  def handle(req, state) do
    index = EEx.compile_file("templates/archives.html.eex")
    template = EEx.compile_file("templates/layout.html.eex")

    {index_result, _} = Code.eval_quoted(index, [articles: Coil.articles])
    {result, _} = Code.eval_quoted(template, [title: "Badosu's Archives",
                                              content: index_result])

    {:ok, req} = :cowboy_req.reply(200, [], result, req)
    {:ok, req, state}
  end

  def init(_transport, req, []), do: {:ok, req, nil}

  def terminate(_reason, _req, _state), do: :ok

end