# Justfile for Onyx project automation

# Copy devShell to remote host using nix-copy-closure
copy:
	nix-copy-closure --to root@onyx.ovh $(nix build .#devShells.x86_64-linux.default --no-link --print-out-paths)

bs:
	melos bs

apk:
	cd apps/onyx && flutter build apk --release

apk-p:
	cd apps/onyx && flutter build apk --profile

apk-rs:
	cd apps/onyx && flutter build apk --release --no-tree-shake-icons --split-per-abi

apk-ps:
	cd apps/onyx && flutter build apk --profile --no-tree-shake-icons --split-per-abi

web:
	cd apps/onyx && flutter build web --release --no-tree-shake-icons --split-per-abi

linux:
	cd apps/onyx && flutter build linux

release:
	just apk
	just linux
	just web

run:
	cd apps/onyx && flutter run
