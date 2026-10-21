{
  fetchFromGitLab,
  jre,
  lib,
  makeWrapper,
  maven,
}:

maven.buildMavenPackage (finalAttrs: {
  pname = "rpgmaker-mv-decrypter";
  version = "0.4.2";

  src = fetchFromGitLab {
    owner = "Petschko";
    repo = "Java-RPG-Maker-MV-Decrypter";
    rev = "f88d02e3b545e29829e0dfa553128c0bc3bfc491";
    hash = "sha256-Db2kJOI1PvmKn8caTV0VKt7eCOvnlgCmtbMLedFyvHI=";
  };

  mvnHash = "sha256-JEdHcjxelHI7z8tCYd7zKKm2vTMW3MgpNgsVc61OiWQ=";

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/rpgmaker-mv-decrypter
    install -Dm644 "/build/source/target/RPG Maker MV Decrypter ${finalAttrs.version}.jar" $out/share/rpgmaker-mv-decrypter/rpgmaker-mv-decrypter.jar

    makeWrapper ${jre}/bin/java $out/bin/rpgmaker-mv-decrypter \
      --add-flags "-jar $out/share/rpgmaker-mv-decrypter/rpgmaker-mv-decrypter.jar"

    runHook postInstall
  '';

  meta = {
    description = "This Project is used to decrypt RPG-Maker-MV/MZ-Resource-Files that are encrypted with the Build-In-Encryption of the RPG-Maker.";
    homepage = "https://gitlab.com/Petschko/Java-RPG-Maker-MV-Decrypter";
    license = lib.licenses.mit;
  };
})
