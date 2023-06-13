unit uFrmMain;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls;

type
  TPerson = record
    Name: String;
    Age: Integer;
    Job: String;
    Birthday: String;
  end;

type
  TForm1 = class(TWebForm)
    btnShow: TWebButton;
    procedure WebFormCreate(Sender: TObject);
    procedure btnShowClick(Sender: TObject);
  private
    { Private declarations }
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

procedure TForm1.WebFormCreate(Sender: TObject);
begin
  btnShow.Visible := True;
end;

procedure TForm1.btnShowClick(Sender: TObject);
var
  LData: array of TPerson;

begin
  // initialize the array
  SetLength( LData, 2 );

  // assign first person
  LData[0].Name := 'Holger Flick';
  LData[0].Age := 27;
  LData[0].Job := 'Evangelist';
  LData[0].Birthday := TBclUtils.DateTimeToISO( EncodeDate( 1996, 2, 10 ), false );

  // assign second person
  LData[1].Name := 'Bruno Fierens';
  LData[1].Age := 28;
  LData[1].Job := 'Innovator';
  LData[1].Birthday := TBclUtils.DateTimeToISO( EncodeDate( 1995, 2, 14 ), false );

  // call JavaScript function that you copied from the documentation
  asm
    showTable(LData);
  end;

  btnShow.Visible := False;
end;

end.
