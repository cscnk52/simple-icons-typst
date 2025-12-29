REMOTE_VERSION := `curl -fsSL https://crates.io/api/v1/crates/simpleicons-rs | jq -r '.crate.max_version'`
LOCAL_VERSION := `grep -oP 'version\s*=\s*"\K[0-9.]+' package/typst.toml`

# Build everything
[group('build')]
build: build-package build-docs

# Check for update, prepare for GitHub CI
[group('version')]
version-check:
    if npx semver -r ">{{ LOCAL_VERSION }}" {{ REMOTE_VERSION }} >/dev/null 2>&1; then \
        echo "Updating versions to {{ REMOTE_VERSION }}..."; \
        echo "updated=true" >> "$GITHUB_OUTPUT"; \
        echo "version={{ REMOTE_VERSION }}" >> "$GITHUB_OUTPUT"; \
    else \
        echo "Already up-to-date."; \
        echo "updated=false" >> "$GITHUB_OUTPUT"; \
    fi \

# Update corresponding version
[group('version')]
version-bump:
    sed -i -E 's/^(version\s*=\s*")[^"]+(")/\1'"{{ REMOTE_VERSION }}"'\2/' package/typst.toml
    sed -i -E 's/^(simpleicons-rs\s*=\s*")[^"]+(")/\1'"{{ REMOTE_VERSION }}"'\2/' wasm/Cargo.toml

# Build WebAssembly package
[group('build')]
[working-directory("wasm")]
build-wasm: version-bump
    cargo build --release --target=wasm32-unknown-unknown
    rm -f ../package/simple_icons.wasm
    cp target/wasm32-unknown-unknown/release/simple_icons.wasm ../package/simple_icons.wasm

# Build docs for latest version
[group('build')]
build-docs: build-wasm
    curl -fsSL https://cdn.jsdelivr.net/npm/simple-icons@{{ REMOTE_VERSION }}/data/simple-icons.json > docs/simple-icons.json
    typst compile --root . ./docs/docs.typ simple-icons-typst@v{{ REMOTE_VERSION }}.pdf

# bundler typst package
[group('build')]
[working-directory("package")]
build-package: build-wasm
    7z a ../simple-icons-typst@v{{ REMOTE_VERSION }}.zip .
