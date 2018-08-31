defmodule Github.Response do
  @moduledoc """
    Struct which represents GitHub API response
  """

  @enforce_keys [:body, :headers, :status]
  defstruct [:body, :headers, :status, :current_page, :next_page]
end
