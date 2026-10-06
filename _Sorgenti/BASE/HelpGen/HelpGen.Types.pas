unit HelpGen.Types;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.Actions,
  Vcl.ActnList,
  Vcl.Graphics;

type
  IHelpSubject = interface
    ['{5441E88A-2F03-40FE-BEBC-9D73E2BF38EA}']
    procedure HelpInitGen;
    procedure HelpDoneGen;

    function HelpFolder: string;
    function HelpFilename: string;
    function HelpModuleName: string;
    function HelpCaption: string;
    function HelpMenuItems: string;
    // function HelpActions: string;
    procedure HelpEnumActions(Actions: TList<TContainedAction>);

    function HelpGetAction(const ActionName: string): TCustomAction;
    { Richiesta COMPLETA per la generazione della guida: modello di prompt
      (HelpGen_RichiestaCompleta.txt) piu' il descrittore della form. Serve
      solo a HelpGen: infilata in una conversazione ordinerebbe all'assistente
      di produrre la documentazione invece di rispondere. }
    function HelpDescribeForm: string;
    { Il SOLO descrittore della form, senza istruzioni: cos'e' la scheda, che
      voci ha, che azioni e che filtri. E' questo che si allega a una domanda
      in chat quando si vuole dare il contesto della scheda attiva. }
    function HelpDescribeContext: string;
    function HelpScreenShot: TBitmap;
  end;

implementation

end.
