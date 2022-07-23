unit nl_network;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, nl_data, IdGlobal, dialogs, nl_functions, nl_language,
  IdTCPClient;

//function GetNodeStatus(Host,Port:String):string;
//function GetSumary():boolean;
function SendOrder(OrderString:String):String;
function GetPendings():string;
function GetMainnetTimestamp(Trys:integer=5):int64;
function GetMNsFromNode(Trys:integer=5):string;

implementation

Uses
  nl_mainform, nl_Disk;

{
// Connects a client and returns the nodestatus
function GetNodeStatus(Host,Port:String):string;
var
  Errored : boolean = false;
Begin
result := '';
if Host = '127.0.0.1' then
   begin
   errored := true;
   end;
if not errored then
   begin
   if form1.ClientChannel.Connected then
      begin
         TRY
         form1.ClientChannel.IOHandler.InputBuffer.Clear;
         form1.ClientChannel.Disconnect;
         EXCEPT on E:exception do
            begin
            ToLog(Format(rsError0005,[E.Message]));
            end;
         END{try};
      end;
   form1.ClientChannel.Host:=Host;
   form1.ClientChannel.Port:=StrToIntDef(Port,8080);
      TRY
      form1.ClientChannel.ConnectTimeout:= 3000;
      form1.ClientChannel.ReadTimeout:=3000;
      form1.ClientChannel.Connect;
      form1.ClientChannel.IOHandler.WriteLn('NODESTATUS');
      result := form1.ClientChannel.IOHandler.ReadLn(IndyTextEncoding_UTF8);
      form1.ClientChannel.Disconnect();
      EXCEPT on E:Exception do
         begin
         ToLog(Format(rsError0006,[Host,E.message]));
         end;
      END{try};
   end;
End;
}

{
// Downloads the sumary file from a node
function GetSumary():boolean;
var
  MyStream       : TMemoryStream;
  DownloadedFile : Boolean = false;
  HashLine       : string;
  RanNode        : integer;
  ThisNode       : NodeData;
Begin
result := false;
RanNode := Random(length(ARRAY_Nodes));
ThisNode := ARRAY_Nodes[RanNode];
form1.ClientChannel.Host:=ThisNode.host;
form1.ClientChannel.Port:=ThisNode.port;
form1.ClientChannel.ConnectTimeout:= 1000;
form1.ClientChannel.ReadTimeout:=800;
MyStream := TMemoryStream.Create;
TRY
form1.ClientChannel.Connect;
form1.ClientChannel.IOHandler.WriteLn('GETZIPSUMARY');
   TRY
   HashLine := form1.ClientChannel.IOHandler.ReadLn(IndyTextEncoding_UTF8);
   ToLog(format(rsGUI0017,[parameter(HashLine,1)]));
   form1.ClientChannel.IOHandler.ReadStream(MyStream);
   result := true;
   DownloadedFile := true;
   MyStream.SaveToFile(ZipSumaryFilename);
   EXCEPT on E:Exception do
      begin
      ToLog(Format(rsError0008,[form1.ClientChannel.Host]));
      end;
   END{Try};
EXCEPT on E:Exception do
   begin
   ToLog(Format(rsError0008,[form1.ClientChannel.Host]));
   end;
END{try};
if form1.ClientChannel.Connected then form1.ClientChannel.Disconnect();
MyStream.Free;
if DownloadedFile then UnZipSumary();
End;
}

// Sends a order to the mainnet
function SendOrder(OrderString:String):String;
var
  Client    : TidTCPClient;
  RanNode   : integer;
  ThisNode  : NodeData;
  TrysCount : integer = 0;
  WasOk     : Boolean = false;
Begin
Result := '';
Client := TidTCPClient.Create(nil);
REPEAT
Inc(TrysCount);
RanNode := Random(length(ARRAY_Nodes));
ThisNode := ARRAY_Nodes[RanNode];
Client.Host:=ThisNode.host;
Client.Port:=thisnode.port;
Client.ConnectTimeout:= 3000;
Client.ReadTimeout:=3000;
//Tolog(OrderString);
TRY
Client.Connect;
Client.IOHandler.WriteLn(OrderString);
Result := Client.IOHandler.ReadLn(IndyTextEncoding_UTF8);
WasOK := True;
EXCEPT on E:Exception do
   begin
   ToLog(Format(rsError0015,[E.Message]));
   end;
END{Try};
UNTIL ( (WasOk) or (TrysCount=3) );
if result <> '' then REF_Addresses := true;
if client.Connected then Client.Disconnect();
client.Free;
End;

function GetPendings():string;
var
  Client : TidTCPClient;
  RanNode  : integer;
  ThisNode : NodeData;
Begin
Result := '';
RanNode := Random(length(ARRAY_Nodes));
ThisNode := ARRAY_Nodes[RanNode];
Client := TidTCPClient.Create(nil);
Client.Host:=Thisnode.host;
Client.Port:=thisnode.port;
Client.ConnectTimeout:= 1000;
Client.ReadTimeout:=1500;
TRY
Client.Connect;
Client.IOHandler.WriteLn('NSLPEND');
Result := Client.IOHandler.ReadLn(IndyTextEncoding_UTF8);
REF_Addresses := true;
EXCEPT on E:Exception do
   begin
   ToLog(Format(rsError0014,[E.Message]));
   Int_LastPendingCount := 0;
   end;
END;{Try}
if client.Connected then Client.Disconnect();
client.Free;
End;

function GetMainnetTimestamp(Trys:integer=5):int64;
var
  Client : TidTCPClient;
  RanNode : integer;
  ThisNode : NodeData;
  WasDone : boolean = false;
Begin
Result := 0;
Client := TidTCPClient.Create(nil);
REPEAT
   ThisNode := PickRandomNode;
   Client.Host:=ThisNode.host;
   Client.Port:=ThisNode.port;
   Client.ConnectTimeout:= 1000;
   Client.ReadTimeout:= 1000;
   TRY
   Client.Connect;
   Client.IOHandler.WriteLn('NSLTIME');
   Result := StrToInt64Def(Client.IOHandler.ReadLn(IndyTextEncoding_UTF8),0);
   WasDone := true;
   EXCEPT on E:Exception do
      begin
      WasDone := False;
      end;
   END{Try};
Inc(Trys);
UNTIL ( (WasDone) or (Trys = 5) );
if client.Connected then Client.Disconnect();
client.Free;
End;

function GetMNsFromNode(Trys:integer=5):string;
var
  Client : TidTCPClient;
  RanNode : integer;
  ThisNode : NodeData;
  WasDone : boolean = false;
Begin
Result := '';
Client := TidTCPClient.Create(nil);
REPEAT
   ThisNode := PickRandomNode;
   Client.Host:=ThisNode.host;
   Client.Port:=ThisNode.port;
   Client.ConnectTimeout:= 3000;
   Client.ReadTimeout:= 3000;
   TRY
   Client.Connect;
   Client.IOHandler.WriteLn('NSLMNS');
   Result := Client.IOHandler.ReadLn(IndyTextEncoding_UTF8);
   WasDone := true;
   EXCEPT on E:Exception do
      begin
      WasDone := False;
      end;
   END{Try};
Inc(Trys);
UNTIL ( (WasDone) or (Trys = 5) );
if client.Connected then Client.Disconnect();
client.Free;
End;

END. // END UNIT.

