rustup default nightly-2020-04-10

set -e

#Build custom runner
cd runner
cargo  build
cd -

#Build APP
cd app
cargo  build --target=x86_64-fortanix-unknown-sgx
cd -

#Convert the APP
ftxsgx-elf2sgxs app/target/x86_64-fortanix-unknown-sgx/debug/app --heap-size 0x20000 --stack-size 0x20000 --threads 1 --debug

#Execute
runner/target/debug/runner app/target/x86_64-fortanix-unknown-sgx/debug/app.sgxs
