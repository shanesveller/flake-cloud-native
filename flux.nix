{ buildGoModule, fetchFromGitHub, lib, installShellFiles }:

let version = "0.5.4";
in buildGoModule {
  pname = "flux2";
  inherit version;

  # https://github.com/fluxcd/flux2/releases/latest
  # https://github.com/fluxcd/flux2/releases/tag/v0.5.4
  # nix-prefetch-url --unpack https://github.com/fluxcd/flux2/archive/v0.5.4.tar.gz
  src = fetchFromGitHub {
    owner = "fluxcd";
    repo = "flux2";
    rev = "v${version}";
    sha256 = "077dxcq6fk86ihj4qx2nijwlvnn6z1bkg5shdq021sx56bp34yyr";
  };

  vendorSha256 = "wZ8agqjT3z95qKGBtbm/IkXraWVXoGJPcPiWVIgwirI=";

  subPackages = [ "cmd/flux" ];

  doCheck = false;

  # https://github.com/fluxcd/flux2/blob/v0.5.4/.goreleaser.yml#L6
  buildFlagsArray = [ "-ldflags=-s -w -X main.VERSION=${version}" ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    for shell in bash fish zsh; do
      $out/bin/flux completion $shell > flux.$shell
      installShellCompletion flux.$shell
    done
  '';

  meta = with lib; {
    description = "Kubernetes toolkit for assembling CD pipelines the GitOps way";
    homepage = "https://github.com/fluxcd/flux2";
    license = licenses.asl20;
    maintainers = [];
    platforms = platforms.unix;
  };
}
