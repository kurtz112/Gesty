// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program capac;

uses
  Winapi.ShellAPI,
  Winapi.Windows;

{$R *.res}

begin

  ShellExecute(0, 'open', PChar('Gesty.exe'), nil, nil, SW_SHOWNORMAL);

end.
