{ buildGoModule, fetchFromGitHub, lib, installShellFiles }:

let version = "0.8.0";
in buildGoModule {
  pname = "flux2";
  inherit version;

  # https://github.com/fluxcd/flux2/releases/latest
  # https://github.com/fluxcd/flux2/releases/tag/v0.8.0
  # nix-prefetch-url --unpack https://github.com/fluxcd/flux2/archive/v0.8.0.tar.gz
  src = fetchFromGitHub {
    owner = "fluxcd";
    repo = "flux2";
    rev = "v${version}";
    sha256 = "1k7zcn8l60qfgiixkjcmp94w87w88n475mmhf58vl5pfz21p9vky";
  };

  vendorSha256 = "fVtyWXa/E1U0+o7snNlWTLC7o/sDWDLFmvLnf8jv0Zs=";

  subPackages = [ "cmd/flux" ];

  doCheck = false;

  # https://github.com/fluxcd/flux2/blob/v0.8.0/.goreleaser.yml#L6
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
