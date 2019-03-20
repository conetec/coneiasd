unit calendario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls;

type
  Tfrmcalendario = class(TForm)
    ocal: TMonthCalendar;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcalendario: Tfrmcalendario;

implementation

{$R *.DFM}

procedure Tfrmcalendario.FormActivate(Sender: TObject);
begin
  ocal.Date:=date;
end;

end.
