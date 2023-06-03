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

procedure TForm1.ProcessResult(AResponse: TJSXMLHttpRequest);
begin
  self.FData := TJSArray( TJsObject( AResponse.response )['results'] );
  //       pagination: true,
  //      paginationSize: 10,
  // , formatterParams: { height: "60px", width: "60px" }
  //       , { title: "Description", field: "longDescription", formatter: "textarea" }
  asm
    var table = new Tabulator("#example-table", {
      data:this.FData,

      columns: [
         { title: "Cover", field: "artworkUrl100", formatter: "image" }
       , { title: "Title", field: "trackName", headerFilter: "input" }
       , { title: "Release", field: "releaseDate", formatter: "datetime", formatterParams: { inputFormat: "iso", outputFormat: "dd/MM/yyyy" } }
       , { title: "Genre", field: "primaryGenreName", headerFilter: "list", headerFilterParams: { autocomplete: true, valuesLookup: true, clearable: true } }
       ]
    });
  end;

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

end.
