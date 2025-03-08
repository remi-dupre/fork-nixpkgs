{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "dstask";
  version = "0.27";

  src = fetchFromGitHub {
    owner = "naggie";
    repo = pname;
    rev = version;
    sha256 = "sha256-bepG8QuOJnV2j1AWNSmfExx+Kpg0TIIhhuS54kftbQc=";
  };

  vendorHash = "sha256-/0ZCqL2dXgeeYlcBmkIOGcB+XJ0J2mSV5xOQJT3Dy9k=";
  doCheck = false;

  # The ldflags reduce the executable size by stripping some debug stuff.
  # The other variables are set so that the output of dstask version shows the
  # git ref and the release version from github.
  # Ref <https://github.com/NixOS/nixpkgs/pull/87383#discussion_r432097657>
  ldflags = [
    "-w"
    "-s"
    "-X github.com/naggie/dstask.VERSION=${version}"
    "-X github.com/naggie/dstask.GIT_COMMIT=v${version}"
  ];

  meta = with lib; {
    description = "Command line todo list with super-reliable git sync";
    homepage = src.meta.homepage;
    license = licenses.mit;
    maintainers = with maintainers; [ stianlagstad ];
    platforms = platforms.linux;
  };
}
