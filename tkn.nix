{ buildGoModule, fetchFromGitHub, lib, installShellFiles }:
let version = "0.17.1";
in buildGoModule {
  pname = "tkn";
  inherit version;

  # https://github.com/tektoncd/cli/releases/latest
  # https://github.com/tektoncd/cli/releases/tag/v0.17.1
  # nix-prefetch-url --unpack https://github.com/tektoncd/cli/archive/v0.17.1.tar.gz
  src = fetchFromGitHub {
    owner = "tektoncd";
    repo = "cli";
    rev = "v${version}";
    sha256 = "08skfixdankwb7d3vg1gfnw15gnwyhrflab4m38dr51bkm4161f7";
  };

  vendorSha256 = null;

  subPackages = [ "cmd/tkn" ];

  doCheck = false;

  # https://github.com/tektoncd/cli/blob/v0.17.1/.goreleaser.yml#L18
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
