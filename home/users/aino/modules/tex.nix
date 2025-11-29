{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    (texlive.combine {
      inherit (texlive) scheme-medium
        csquotes;
    })
  ];

  home.file.".latexmkrc".text = ''
    $pdf_mode = 1;
    $emulate_aux = 1;
    $out_dir = '.';
    $aux_dir = '/tmp/latexmk';
  '';
}
