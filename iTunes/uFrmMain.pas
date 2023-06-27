unit uFrmMain;

interface

uses
    System.SysUtils
  , System.Classes
  , JS
  , Web
  , WEBLib.Graphics
  , WEBLib.Controls
  , WEBLib.Forms
  , WEBLib.Dialogs
  , Vcl.Controls
  , Vcl.StdCtrls
  , WEBLib.StdCtrls
  , WEBLib.REST
  ;

type
  TFrmMain = class(TWebForm)
    btnShow: TWebButton;
    Request: TWebHttpRequest;
    procedure btnShowClick(Sender: TObject);
  private
    { Private declarations }
    FData: TJSArray;
  public
    { Public declarations }
    procedure ProcessResult( AResponse: TJSXMLHttpRequest );

    [async] procedure RequestData;
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.ProcessResult(AResponse: TJSXMLHttpRequest);
begin
  // Response can be used directly!
  console.log( AResponse.response );

  // assign data to global variable
  self.FData := TJSArray( TJsObject( AResponse.response )['results'] );

  // pass data to grid and display
  {$IFDEF pas2js}
  asm
    showTable(this.FData)
  end;
  {$ENDIF}
end;

procedure TFrmMain.RequestData;
var
  LResponse: TJSXMLHttpRequest;

begin
  // wait for data request to be received
  LResponse := await( TJSXMLHttpRequest, Request.Perform );

  // proceed if status code is 200
  if LResponse.Status = 200 then
  begin
    // process result and show grid
    ProcessResult( LResponse );
  end;
end;

procedure TFrmMain.btnShowClick(Sender: TObject);
begin
  btnShow.Visible := False;
  RequestData;
end;


(*
  //  { title: "Cover", field: "artworkUrl100", formatter: "image", ... }
  TColumn = record
    title: String;
    field: String;
    formatter: String;
    headerFilter: String;
    editor: Boolean;
  end;

var
  LColumns: Array of TColumn;
  LcolumnCover,
  LColumnTitle: TColumn;


  // -- definining columns in Pascal code
  // -- ignore this at first!
  // -- this is also not used for the video shown
  SetLength( LColumns, 2 );
  LColumnCover.title := 'Cover';
  LColumnCover.field := 'artworkUrl100';
  LColumnCover.formatter := 'image';

  LColumnTitle.title := 'Title';
  LColumnTitle.field := 'tackName';
  LColumnTitle.headerFilter := 'input';
  LColumnTitle.editor := true;

  LColumns[0] := LColumnCover;
  LColumns[1] := LColumnTitle;
  console.log( Js.toObject( LColumns ) );

  *)

end.
