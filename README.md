# Siphasher

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

## Installation

The package can be installed by adding siphasher to your list of dependencies in mix.exs:

```elixir
def deps do
  [
    {:siphasher, "~> 0.1.0"}
  ]
end
```

## Example
```elixir
iex> SipHasher.hash("0123456789ABCDEF", "hello")
{:ok, 4402678656023170274}

iex> SipHasher.hash!("0123456789ABCDEF", "hello")
4402678656023170274
```
