unit uFrmMain;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls;


type
  TCustomer = class
    Name: String;
    Age: Integer;
  end;

type
  TForm1 = class(TWebForm)
    WebButton1: TWebButton;
    procedure WebButton1Click(Sender: TObject);
  private
    { Private declarations }
    FData: array of TJSObject;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Bcl.Utils,
  DateUtils
  ;

procedure TForm1.WebButton1Click(Sender: TObject);
var
  LC: TCustomer;

begin
  LC := TCustomer.Create;
  console.log( JS.toObject( LC ) );

  SetLength( FData, 2 );

  FData[0] := TJSObject.new;
  FData[0]['Name'] := 'Holger Flick';
  FData[0]['Age'] := 44;
  FData[0]['Job'] := 'Evengelist';
  FData[0]['Birthday'] := TBclUtils.DateTimeToISO( EncodeDate( 1979, 5, 11 ), false );

  FData[1] := TJSObject.new;
  FData[1]['Name'] := 'Bruno Fierens';
  FData[1]['Age'] := 54;
  FData[1]['Job'] := 'Innovator';
  FData[1]['Birthday'] := TBclUtils.DateTimeToISO( EncodeDate( 1969, 4, 18 ), false );




  asm
    var table = new Tabulator("#example-table", {
      data:this.FData, //assign data to table
      columns: [
         { title: "Name", field: "Name", editor: "input", sorter: "string" }
       , { title: "Age", field: "Age", editor: "number", sorter: "number" }
       , { title: "Job", field: "Job", editor: "input", sorter: "string" }
       , { title: "Birthday", field: "Birthday", editor: "date", sorter: "date" }
       ]
    });
  end;
end;

end.
