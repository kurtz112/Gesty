unit Init_Controls;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Buttons,
  ExtCtrls,
  Grids,
  Menus,
  db,
  ComCtrls,
  ActnList,
  dbctrls,
  FileCtrl,
  Mask,
  ToolWin,
  DbGrids,
  zDbView,
  zDbCard,
  zDbRecordView,
  zDbTree,
  zDbChart,
  cxPC;

procedure Init_Ctrls(aOwner: TComponent);

implementation

uses
  zDm_Images,
  ConfigModule,
  zFileViewer,
  dxNavBar,
  dxNavBarCollns,
  dxNavBarBase,
  dxNavBarConsts,
  dxNavBarViewsFact,
  dxNavBarSkinBasedViews,
  dxNavBarOffice12Views,
  cxSplitter,
  dxLayoutControl,
  zDbScheduler,
  zDX;

procedure Init_Ctrls(aOwner: TComponent);
var
  cxPageControl: TcxPageControl;
  i, x: integer;
  s: string;
  ii: integer;
  NavBar: TdxNavBar;
begin

  if not Assigned(aOwner) then
    exit;

  for i := 0 to aOwner.ComponentCount - 1 do
  begin

    if aOwner.Components[i] is TdxLayoutControl then
    begin
      dx.InitLayoutControl(aOwner.Components[i] as TdxLayoutControl);
    end
    else
      if aOwner.Components[i] is TcxPageControl then
      begin
        dx.InitPageControl(aOwner.Components[i] as TcxPageControl);
      end
      else
        if aOwner.Components[i] is TcxSplitter then
        begin
          dx.InitSplitter(aOwner.Components[i] as TcxSplitter);
        end
        else
          if aOwner.Components[i] is TzDbView then
            with aOwner.Components[i] as TzDbView do
            begin
              zSystem := Config.zSystem;
              for ii := 0 to ToolActions.Count - 1 do
                if not Assigned(ToolActions[ii].ImageList) then
                  ToolActions[ii].ImageList := zDmImages.ImageList16;
            end
          else
            if aOwner.Components[i] is TzDbCard then
              with aOwner.Components[i] as TzDbCard do
              begin
                zSystem := Config.zSystem;
                for ii := 0 to ToolActions.Count - 1 do
                  if not Assigned(ToolActions[ii].ImageList) then
                    ToolActions[ii].ImageList := zDmImages.ImageList16;
              end
            else
              if aOwner.Components[i] is TzDbRecordView then
                with aOwner.Components[i] as TzDbRecordView do
                begin
                  zSystem := Config.zSystem;
                  for ii := 0 to ToolActions.Count - 1 do
                    if not Assigned(ToolActions[ii].ImageList) then
                      ToolActions[ii].ImageList := zDmImages.ImageList16;
                end
              else
              if aOwner.Components[i] is TzDbTree then
                with aOwner.Components[i] as TzDbTree do
                begin
                  zSystem := Config.zSystem;
                  for ii := 0 to ToolActions.Count - 1 do
                    if not Assigned(ToolActions[ii].ImageList) then
                      ToolActions[ii].ImageList := zDmImages.ImageList16;
                end
              else
              if aOwner.Components[i] is TzDbChart then
                with aOwner.Components[i] as TzDbChart do
                begin
                  zSystem := Config.zSystem;
                  for ii := 0 to ToolActions.Count - 1 do
                    if not Assigned(ToolActions[ii].ImageList) then
                      ToolActions[ii].ImageList := zDmImages.ImageList16;
                end
              else
              if aOwner.Components[i] is TzDbScheduler then
                with aOwner.Components[i] as TzDbScheduler do
                begin
                  // le azioni aggiunte dalla form con AddToolbarButton usano le
                  // icone dell'applicazione, come in Frame_Scheduler
                  FreeBarImages := zDmImages.ImageList16;
                  // dizionario LZ: senza zDataSet (frame delle form) non cambia nulla
                  zSystem := Config.zSystem;
                  for ii := 0 to ToolActions.Count - 1 do
                    if not Assigned(ToolActions[ii].ImageList) then
                      ToolActions[ii].ImageList := zDmImages.ImageList16;
                end
              else
              if aOwner.Components[i] is TdxNavBar then
              begin
                NavBar := TdxNavBar(aOwner.Components[i]);
                NavBar.view := dxNavBarViewsFactory.IDs[dxNavBarOffice12NavigatorPaneView];

                if NavBar.ViewStyle is TdxNavBarSkinBasedNavPanePainter then
                  TdxNavBarSkinBasedNavPanePainter(NavBar.ViewStyle).ColorSchemeName := 'Silver';

                NavBar.OptionsBehavior.Common.AllowSelectLinks := true;
                NavBar.OptionsBehavior.Common.EachGroupHasSelectedLink := true;
                NavBar.OptionsBehavior.NavigationPane.AdjustWidthByPopup := true;
                NavBar.OptionsBehavior.NavigationPane.Collapsible := true;
                NavBar.OptionsBehavior.NavigationPane.AllowCustomizing := False;
                NavBar.OptionsView.NavigationPane.ShowActiveGroupCaptionWhenCollapsed := true;
                NavBar.OptionsView.NavigationPane.ShowOverflowPanel := False;
                NavBar.OptionsStyle.DefaultStyles.GroupBackground.BackColor := clMoneyGreen;
                NavBar.OptionsStyle.DefaultStyles.GroupBackground.BackColor2 := clMoneyGreen;
                NavBar.LargeImages := zDmImages.ImageList24;
                NavBar.SmallImages := zDmImages.ImageList16;
                NavBar.ActiveGroupIndex := 0;
              end;
  end;
end;

end.
