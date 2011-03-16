unit GPIB;

interface

uses  num2str,ieeedel;

var  A34970_Stat,K6220_Stat :integer;
     Length     :word;

const K6220=11;

procedure K6220_Send(Command:string);
function  K6220_Read(command:string):string;
procedure K6220_Standby;
procedure K6220_Operate;
procedure K6220_Compliance(value:real);
Procedure K6220_Range(value:real);
procedure K6220_CurrApply(value:real);
procedure K6220_Init;
function  A34970_Read:real;
procedure A34970_Send(Command:string);
procedure A34970_Init;

implementation
{--------------------------------------------------}

Procedure K6220_Send(command:string);
 begin
  SEND(K6220,command,K6220_Stat);
  delay(100);
 end;{K6220_Send}
{--------------------------------------------------}

Function  K6220_Read(command:string):string;
var res: string;
 begin
  SEND(K6220,command,K6220_Stat);
  delay(200);
  ENTER(res,80,Length,K6220,K6220_Stat);
  K6220_Read:=res;
  delay(100);
 end;{K6220_Read}
{--------------------------------------------------}

Procedure K6220_Standby;
 begin
  K6220_Send('OUTPut OFF');
 end;{K6220_Standby}
{--------------------------------------------------}

Procedure K6220_Operate;
 begin
  K6220_Send('OUTPut ON');
 end;{K6220_Operate}
{--------------------------------------------------}

Procedure K6220_Compliance(value:real);
 begin
  K6220_Send('CURR:COMP '+real2str(value,-1,3));
 end;{K6220_Compliance}
{--------------------------------------------------}

Procedure K6220_Range(value:real);
 begin
  K6220_Send('CURR:RANG '+real2str(value,-1,6));
 end;{K6220_Range
{--------------------------------------------------}

Procedure K6220_CurrApply(value:real);
var retez:string;
 begin
  retez:='CURR '+real2str(value,11,9);
  K6220_Send(retez);
  K6220_Operate;
 end;{K6220_CurrApply}
{--------------------------------------------------}

Procedure K6220_Init;
var i:integer;
 begin
   K6220_Send('CLE');
   K6220_Compliance(30.0);
 end;{K6220_Init}
{--------------------------------------------------}

function A34970_Read:real;
var retez:string;
    kod:integer;
    pomr:real;
begin
 Enter(retez,80,Length,A34970,A34970_Stat);
 val(retez,pomr,kod);
 if kod=0 then A34970_Read:=pomr else A34970_Read:=0.0;
end;
{--------------------------------------------------}

procedure A34970_Send;

begin
 Send(A34970,Command,A34970_Stat);
 delay(100);
end;
{--------------------------------------------------}

procedure A34970_Init;

begin
 A34970_Send('SYST:PRES');
 delay(200);
end;
{--------------------------------------------------}


end.






