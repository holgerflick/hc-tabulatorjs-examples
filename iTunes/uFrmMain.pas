unit uFrmMain;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls,
  WEBLib.REST;


type
  TForm1 = class(TWebForm)
    btnShow: TWebButton;
    Request: TWebHttpRequest;
    procedure btnShowClick(Sender: TObject);
  private
    { Private declarations }
    FData: TJSArray;
  public
    { Public declarations }
    procedure ProcessResult( AResponse: TJSXMLHttpRequest );

    [async] procedure ShowData;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



uses
  Bcl.Utils,
  DateUtils
  ;

type

  //  { title: "Cover", field: "artworkUrl100", formatter: "image" }
  TColumn = record
    title: String;
    field: String;
    formatter: String;
    headerFilter: String;
    editor: Boolean;
  end;

procedure TForm1.ProcessResult(AResponse: TJSXMLHttpRequest);
var
  LColumns: Array of TColumn;
  LcolumnCover,
  LColumnTitle: TColumn;

begin
  SetLength( LColumns, 2 );

  LColumnCover.title := 'Cover';
  LColumnCover.field := 'artworkUrl100';
  LColumnCover.formatter := 'image';

  LColumnTitle.title := 'Title';
  LColumnTitle.field := 'tackName';
  LColumnTitle.headerFilter := 'input';
  LColumnTitle.editor := true;

  Lcolumns[0] := LColumnCover;
  LColumns[1] := LColumnTitle;

  console.log( Js.toObject( LColumns ) );

  self.FData := TJSArray( TJsObject( AResponse.response )['results'] );

  {$IFDEF pas2js}
  asm
    showTable(this.FData)
  end;
  {$ENDIF}
end;

procedure TForm1.ShowData;
var
  LResponse: TJSXMLHttpRequest;

begin
  LResponse := await( TJSXMLHttpRequest, Request.Perform );

  if LResponse.Status = 200 then
  begin
    ProcessResult( LResponse );
  end;
end;

procedure TForm1.btnShowClick(Sender: TObject);
begin
  btnShow.Visible := False;
  ShowData;
end;

  //       pagination: true,
  //      paginationSize: 10,
  // , formatterParams: { height: "60px", width: "60px" }
  //       , { title: "Description", field: "longDescription", formatter: "textarea" }

end.
