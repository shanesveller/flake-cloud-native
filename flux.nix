{ buildGoModule, fetchFromGitHub, lib, installShellFiles }:

buildGoModule rec {
  pname = "flux2";
  version = "0.4.3";

  # https://github.com/fluxcd/flux2/releases/latest
  # https://github.com/fluxcd/flux2/releases/tag/v0.4.3
  # nix-prefetch-url --unpack https://github.com/fluxcd/flux2/archive/v0.4.3.tar.gz
  src = fetchFromGitHub {
    owner = "fluxcd";
    repo = "flux2";
    rev = "v${version}";
    sha256 = "0003yddh5ziq16wh5pyljrhhcmj80gw730vb0d4z9f26bxg1dapm";
  };

  vendorSha256 = "zzkNe4Y2mTgUGvhlz1/p4erdJ51Yw0mV+NB1AKzWX4k=";

  subPackages = [ "cmd/flux" ];

  doCheck = false;

  # https://github.com/fluxcd/flux2/blob/v0.4.3/.goreleaser.yml#L6
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
