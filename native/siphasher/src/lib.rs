use siphasher::sip::SipHasher;
use std::hash::Hasher;

#[rustler::nif]
fn hash(key1: u64, key2: u64, input: &str) -> u64 {
    SipHasher::new_with_keys(key1, key2).run(input)
}

trait HasherExt {
    fn run(&mut self, input: &str) -> u64;
}

impl<T: Hasher> HasherExt for T {
    fn run(&mut self, input: &str) -> u64 {
        self.write(input.as_bytes());
        self.finish()
    }
}

rustler::init!("Elixir.SipHasher.Native", [hash]);
