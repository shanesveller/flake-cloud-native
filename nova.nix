{ buildGoModule, fetchFromGitHub, lib }:
let version = "2.3.1";
in buildGoModule {
  pname = "nova";
  inherit version;

  # https://github.com/FairwindsOps/nova/releases/latest
  # https://github.com/FairwindsOps/nova/releases/tag/2.3.1
  # nix-prefetch-url --unpack https://github.com/FairwindsOps/nova/archive/2.3.1.tar.gz
  src = fetchFromGitHub {
    owner = "FairwindsOps";
    repo = "nova";
    rev = version;
    sha256 = "146l3ggrz6bz2mkmsr4807rsxalvfylyzj2myhsrgd1v64b5hfgj";
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
