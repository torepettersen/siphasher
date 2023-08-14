defmodule SipHasher.Native do
  @moduledoc false

  mix_config = Mix.Project.config()
  version = mix_config[:version]
  github_url = mix_config[:package][:links]["GitHub"]

  use RustlerPrecompiled,
    otp_app: :siphasher,
    version: version,
    base_url: "#{github_url}/releases/download/v#{version}",
    force_build: System.get_env("SIPHASHER_BUILD") in ["1", "true"]

  def hash(_key1, _key2, _value), do: :erlang.nif_error(:nif_not_loaded)
end
