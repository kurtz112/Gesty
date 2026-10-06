unit BaseWeb.Types;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TBaseWebNodeKind = (nkDataset,
  nkSectionFields,
  nkSectionForm,
  nkSectionGrid,
  nkField,
  nkFormTabbed,
  nkFormTab,
  nkFormGroup,
  nkFormField,
  nkFormButton,
  nkFormEmpty,
  nkGridBand,
  nkGridColumn,
  nkLookup,
  nkLookupColumn,
  nkPicklist,
  nkPicklistItem);

  TBaseWebNodeData = class
    Kind: TBaseWebNodeKind;
    ModelObject: TComponent;
    DisplayText: string;
  end;

implementation

end.
