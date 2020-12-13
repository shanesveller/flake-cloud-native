{ buildGoModule, fetchFromGitHub, lib, installShellFiles }:
let version = "0.14.0";
in buildGoModule {
  pname = "tkn";
  inherit version;

  # https://github.com/tektoncd/cli/releases/latest
  # https://github.com/tektoncd/cli/releases/tag/v0.14.0
  # nix-prefetch-url --unpack https://github.com/tektoncd/cli/archive/v0.14.0.tar.gz
  src = fetchFromGitHub {
    owner = "tektoncd";
    repo = "cli";
    rev = "v${version}";
    sha256 = "1mkbwh4cmhx9in928vlvs7xjjklpsxbv5niv8jmsbnifflg1an8p";
  };

  vendorSha256 = null;

  subPackages = [ "cmd/tkn" ];

  doCheck = false;

  # https://github.com/tektoncd/cli/blob/v0.14.0/.goreleaser.yml#L18
  buildFlagsArray = [
    "-ldflags=-s -w -X github.com/tektoncd/cli/pkg/cmd/version.clientVersion=${version}"
  ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    for shell in bash fish zsh; do
      $out/bin/tkn completion $shell > tkn.$shell
      installShellCompletion tkn.$shell
    done
  '';

  meta = with lib; {
    description = " A CLI for interacting with Tekton!";
    homepage = "https://github.com/tektoncd/cli";
    license = licenses.asl20;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
