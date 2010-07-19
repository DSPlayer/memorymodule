unit Main;

{ * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  * Memory DLL loading code Demo Dll					    *
  *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*
  * Copyright (c) 2005-2010 by Martin Offenwanger / coder@dsplayer.de       *
  * http://www.dsplayer.de                                                  *
  *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*
  * Mozilla Public License Version 1.1:                                     *
  *- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*
  * The contents of this file are used with permission, subject to the      *
  * Mozilla Public License Version 1.1 (the "License"); you may             *
  * not use this file except in compliance with the License. You may        *
  * obtain a copy of the License at                                         *
  * http://www.mozilla.org/MPL/MPL-1.1.html                                 *
  *                                                                         +
  * Software distributed under the License is distributed on an             *
  * "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or          *
  * implied. See the License for the specific language governing            *
  * rights and limitations under the License.                               *
  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * }
{
  @author(Martin Offenwanger: coder@dsplayer.de)
  @created(Mar 20, 2005)
  @lastmod(Jul 16, 2010)
  @supported operationg systems(Windows 98 up to Windows 7)
  @tested Delphi compilers(Delphi 7, Delphi 2007 , Delphi 2010)
}

{$mode objfpc}{$H+}

{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CAST OFF}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Windows, BTMemoryModule;

type

  TTestCallstdA = procedure(f_Text: PAnsiChar); stdcall;
  PTestCallstdA = ^TTestCallstdA;
  TTestCallstdW = procedure(f_Text: PWideChar); stdcall;
  PTestCallstdW  = ^TTestCallstdW;
  TTestCallcdelA = procedure(f_Text: PAnsiChar); cdecl;
  PTestCallcdelA = ^TTestCallcdelA;
  TTestCallcdelW = procedure(f_Text: PWideChar); cdecl;
  PTestCallcdelW = ^TTestCallcdelW;

  { TFrmMain }

  TFrmMain = class(TForm)
    BtnFileCall: TButton;
    BtnMemCall:  TButton;
    procedure BtnFileCallClick(Sender: TObject);
    procedure BtnMemCallClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    mp_TestCallstdA: PTestCallstdA;
    mp_TestCallstdW: PTestCallstdW;
    mp_TestCallcdelA: PTestCallcdelA;
    mp_TestCallcdelW: PTestCallcdelW;
    mp_DllData:      Pointer;
    m_DllDataSize:   integer;
    mp_MemoryModule: PBTMemoryModule;
    m_DllHandle:     cardinal;
  end;

var
  FrmMain: TFrmMain;

implementation

{ TFrmMain }

procedure TFrmMain.FormCreate(Sender: TObject);
var
  MemoryStream: TMemoryStream;
begin
  Position := poScreenCenter;
  MemoryStream := TMemoryStream.Create;
  MemoryStream.LoadFromFile('DemoDLL.dll');
  MemoryStream.Position := 0;
  m_DllDataSize := MemoryStream.Size;
  mp_DllData    := GetMemory(m_DllDataSize);
  MemoryStream.Read(mp_DllData^, m_DllDataSize);
  MemoryStream.Free;
end;

procedure TFrmMain.BtnFileCallClick(Sender: TObject);
begin
  BtnFileCall.Enabled := False;
  BtnMemCall.Enabled := False;
  m_DllHandle := LoadLibrary('DemoDLL.dll');
  try
    if m_DllHandle = 0 then
      Abort;
    mp_TestCallstdA := GetProcAddress(m_DllHandle, 'TestCallstdA');
    if mp_TestCallstdA = nil then
      Abort;
    mp_TestCallstdW := GetProcAddress(m_DllHandle, 'TestCallstdW');
    if mp_TestCallstdW = nil then
      Abort;
    mp_TestCallcdelA := GetProcAddress(m_DllHandle, 'TestCallcdelA');
    if mp_TestCallcdelA = nil then
      Abort;
    mp_TestCallcdelW := GetProcAddress(m_DllHandle, 'TestCallcdelW');
    if mp_TestCallcdelW = nil then
      Abort;
    TTestCallstdA(mp_TestCallstdA)('This is a Dll File call!');
    TTestCallstdW(mp_TestCallstdW)('This is a Dll File call!');
    TTestCallcdelA(mp_TestCallcdelA)('This is a Dll File call!');
    TTestCallcdelW(mp_TestCallcdelW)('This is a Dll File call!');
  except
    ShowMessage('An error occoured while loading the dll');
  end;
  if m_DllHandle <> 0 then
    FreeLibrary(m_DllHandle);
  BtnFileCall.Enabled := True;
  BtnMemCall.Enabled  := True;
end;

procedure TFrmMain.BtnMemCallClick(Sender: TObject);
begin
  BtnFileCall.Enabled := False;
  BtnMemCall.Enabled  := False;
  mp_MemoryModule     := BTMemoryLoadLibary(mp_DllData, m_DllDataSize);
  try
    if mp_MemoryModule = nil then
      Abort;
    mp_TestCallstdA := BTMemoryGetProcAddress(mp_MemoryModule, 'TestCallstdA');
    if mp_TestCallstdA = nil then
      Abort;
    mp_TestCallstdW := BTMemoryGetProcAddress(mp_MemoryModule, 'TestCallstdW');
    if mp_TestCallstdW = nil then
      Abort;
    mp_TestCallcdelA := BTMemoryGetProcAddress(mp_MemoryModule, 'TestCallcdelA');
    if mp_TestCallcdelA = nil then
      Abort;
    mp_TestCallcdelW := BTMemoryGetProcAddress(mp_MemoryModule, 'TestCallcdelW');
    if mp_TestCallcdelW = nil then
      Abort;
    TTestCallstdA(mp_TestCallstdA)('This is a dll memory call!');
    TTestCallstdW(mp_TestCallstdW)('This is a dll memory call!');
    TTestCallcdelA(mp_TestCallcdelA)('This is a dll memory call!');
    TTestCallcdelW(mp_TestCallcdelW)('This is a dll memory call!');
  except
    ShowMessage('An error occoured while loading the dll: ' + BTMemoryGetLastError);
  end;
  if mp_MemoryModule <> nil then
    BTMemoryFreeLibrary(mp_MemoryModule);
  BtnFileCall.Enabled := True;
  BtnMemCall.Enabled  := True;
end;


procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FreeMemory(mp_DllData);
end;

initialization
  {$I main.lrs}

end.

