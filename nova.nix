{ buildGoModule, fetchFromGitHub, lib }:
let version = "2.3.0";
in buildGoModule {
  pname = "nova";
  inherit version;

  # https://github.com/FairwindsOps/nova/releases/latest
  # https://github.com/FairwindsOps/nova/releases/tag/2.3.0
  # nix-prefetch-url --unpack https://github.com/FairwindsOps/nova/archive/2.3.0.tar.gz
  src = fetchFromGitHub {
    owner = "FairwindsOps";
    repo = "nova";
    rev = version;
    sha256 = "0c8bm406r44s8nxw41xdch04r1q1andpbq4lgy9h2nhfbcd48bsv";
  };

  vendorSha256 = "2DK5P0szp9R9jt7MYJZB+gV8DwWrsrG3BOvDekN7cbI=";

  subPackages = [ "." ];

  doCheck = false;

  meta = with lib; {
    description =
      "Find outdated or deprecated Helm charts running in your cluster.";
    homepage = "https://github.com/FairwindsOps/nova";
    license = licenses.asl20;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
