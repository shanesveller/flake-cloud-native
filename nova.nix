{ buildGoModule, fetchFromGitHub, lib }:
let version = "2.1.0";
in buildGoModule {
  pname = "nova";
  inherit version;

  # https://github.com/FairwindsOps/nova/releases/latest
  # https://github.com/FairwindsOps/nova/releases/tag/2.1.0
  # nix-prefetch-url --unpack https://github.com/FairwindsOps/nova/archive/2.1.0.tar.gz
  src = fetchFromGitHub {
    owner = "FairwindsOps";
    repo = "nova";
    rev = version;
    sha256 = "166mc9fjsqjdpxzv3ny6vrhw07bk34pp44cmhfn5111f2916kdgz";
  };

  vendorSha256 = "6bonBYcksb+pCrx0EvL2CeHO6+SXA7Qzm4dd9tmtHF4=";

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
