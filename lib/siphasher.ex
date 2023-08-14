defmodule SipHasher do
  @moduledoc """
  Elixir Bindings for the SipHash Algorithm

  This module provides Elixir bindings to the Rust library [siphasher](https://crates.io/crates/siphasher),
  offering the SipHash 2-4 algorithm.

  SipHash is a versatile hashing function known for its speed and strong
  keyed hashing capabilities. It is suitable for hash tables and similar
  applications that require a balance between speed and security.

  SipHash is generally strong but not intended for cryptographic use.
  Cryptographic applications using this implementation are strongly
  discouraged.

  For more details about the SipHash algorithm, refer to:
  https://www.aumasson.jp/siphash/siphash.pdf
  """

  alias SipHasher.Native

  @doc """
  Hashes the input string using the provided key.

  ## Parameters

    * `key` - The 16-byte key used for hashing.
    * `input` - The string to be hashed.

  ## Returns

    * `{:ok, hash}` - The hashed value as an integer.
    * `{:error, message}` - If the input is invalid or key size is incorrect.

  ## Examples

      iex> SipHasher.hash("0123456789ABCDEF", "hello")
      {:ok, 4402678656023170274}

      iex> SipHasher.hash("invalid_bytes", "hello")
      {:error, "Key must be exactly 16 bytes!"}

      iex> SipHasher.hash("0123456789ABCDEF", 123)
      {:error, "Hash input must be a binary!"}
  """
  @spec hash(binary(), binary()) :: {:ok, number()} | {:error, binary()}
  def hash(key, input) when byte_size(key) == 16 and is_binary(input) do
    [key1, key2] =
      for <<key::size(8)-binary <- key>> do
        :binary.decode_unsigned(key, :little)
      end

    {:ok, Native.hash(key1, key2, input)}
  end

  def hash(key, _value) when byte_size(key) != 16,
    do: {:error, "Key must be exactly 16 bytes!"}

  def hash(_key, input) when not is_binary(input),
    do: {:error, "Hash input must be a binary!"}

  @doc """
  Hashes the input string using the provided key.

  This function raises an exception if there's an error.

  ## Parameters

  * `key` - The 16-byte key used for hashing.
  * `input` - The string to be hashed.

  ## Returns

  The hashed value as an integer.

  ## Examples

      iex> SipHasher.hash!("0123456789ABCDEF", "hello")
      4402678656023170274

      iex> SipHasher.hash!("invalid_bytes", "hello")
      ** (ArgumentError) Key must be exactly 16 bytes!

      iex> SipHasher.hash!("0123456789ABCDEF", 123)
      ** (ArgumentError) Hash input must be a binary!
  """
  @spec hash!(binary(), binary()) :: number()
  def hash!(key, input) do
    case hash(key, input) do
      {:ok, hash} -> hash
      {:error, msg} -> raise ArgumentError, message: msg
    end
  end
end
