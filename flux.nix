{ buildGo116Module, fetchFromGitHub, lib, installShellFiles }:

let version = "0.10.0";
in buildGo116Module {
  pname = "flux2";
  inherit version;

  # https://github.com/fluxcd/flux2/releases/latest
  # https://github.com/fluxcd/flux2/releases/tag/v0.10.0
  # nix-prefetch-url --unpack https://github.com/fluxcd/flux2/archive/v0.10.0.tar.gz
  src = fetchFromGitHub {
    owner = "fluxcd";
    repo = "flux2";
    rev = "v${version}";
    sha256 = "0rrz7437g9fpx5xynys139g7lr2zg9xvh3nsgipy9qy5fv4997l8";
  };

  vendorSha256 = "Z0keCr+KZ593c6a/56lYJwOgXu5hrUSn6N3NFf2LDUM=";

  subPackages = [ "cmd/flux" ];

  doCheck = false;

  # https://github.com/fluxcd/flux2/blob/v0.10.0/.goreleaser.yml#L6
  buildFlagsArray = [ "-ldflags=-s -w -X main.VERSION=${version}" ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    for shell in bash fish zsh; do
      $out/bin/flux completion $shell > flux.$shell
      installShellCompletion flux.$shell
    done
  '';

  meta = with lib; {
    description =
      "Kubernetes toolkit for assembling CD pipelines the GitOps way";
    homepage = "https://github.com/fluxcd/flux2";
    license = licenses.asl20;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
