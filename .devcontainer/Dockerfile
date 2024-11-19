# Use the official Rust image as the base image
FROM rust:latest

# Install additional dependencies
# Include lld linker to improve build times either by using environment variable
# RUSTFLAGS="-C link-arg=-fuse-ld=lld" or with Cargo's configuration file (i.e see .cargo/config.toml).
RUN apt-get update && && export DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    clang lld \
    build-essential \
    libssl-dev \
    pkg-config \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove -y && apt-get clean -y

# Set the working directory inside the container
WORKDIR /workspace

# Copy the Cargo.toml and Cargo.lock files first to leverage Docker cache
COPY Cargo.toml Cargo.lock ./

# Create a dummy main.rs file and build the dependencies
RUN mkdir src && echo "fn main() {}" > src/main.rs && cargo build && rm -rf src

# Copy the source code
COPY . .

# Build the Rust application
RUN cargo build

# Set the default command to open a shell
CMD [ "bash" ]