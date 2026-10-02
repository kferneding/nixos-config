{pkgs, ...}: {
  home.packages = with pkgs; [
    sigil
    zotero
    pandoc
    calibre
    texliveFull
    bibtex2html
    ghostscript
    teams-for-linux
  ];
}
