defmodule Github.Client do
  @moduledoc """
    Struct which represents GitHub client
  """

  defstruct [:access_token, :jwt_token]
end
