{ buildGoModule, fetchFromGitHub, lib }:
let version = "2.2.0";
in buildGoModule {
  pname = "nova";
  inherit version;

  # https://github.com/FairwindsOps/nova/releases/latest
  # https://github.com/FairwindsOps/nova/releases/tag/2.2.0
  # nix-prefetch-url --unpack https://github.com/FairwindsOps/nova/archive/2.2.0.tar.gz
  src = fetchFromGitHub {
    owner = "FairwindsOps";
    repo = "nova";
    rev = version;
    sha256 = "1br75af33fjllaf1lj4hza2b4mvvqr9m49gy0r7p480fmc8x8j39";
  };

  vendorSha256 = "Lvit6/6fhbGp7flYzRBUMUSOsmhTYYvmXCCFN9yRaWI=";

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
