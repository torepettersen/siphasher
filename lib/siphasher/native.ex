defmodule SipHasher.Native do
  @moduledoc false
  use Rustler, otp_app: :siphasher, crate: "siphasher"

  def hash(_key1, _key2, _value), do: :erlang.nif_error(:nif_not_loaded)
end
