{ buildGoModule, fetchFromGitHub, lib, installShellFiles }:

let version = "0.7.7";
in buildGoModule {
  pname = "flux2";
  inherit version;

  # https://github.com/fluxcd/flux2/releases/latest
  # https://github.com/fluxcd/flux2/releases/tag/v0.7.7
  # nix-prefetch-url --unpack https://github.com/fluxcd/flux2/archive/v0.7.7.tar.gz
  src = fetchFromGitHub {
    owner = "fluxcd";
    repo = "flux2";
    rev = "v${version}";
    sha256 = "13vd0lw51w2h1yz50xgbqs8h8x1jyjd9c7m17xjzbfxdg9pyxk1d";
  };

  vendorSha256 = "xwzeM+urimzbU7Mma/MjnZUrpxnTKqvEXcHP0C/GEZI=";

  subPackages = [ "cmd/flux" ];

  doCheck = false;

  # https://github.com/fluxcd/flux2/blob/v0.7.7/.goreleaser.yml#L6
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
