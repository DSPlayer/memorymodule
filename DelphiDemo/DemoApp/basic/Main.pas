unit Main;

{ * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  * Memory DLL loading code Demo Application                                *
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

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BTMemoryModule, StdCtrls, xpman;

type
  TTestCallstdA = procedure(f_Text: PAnsiChar); stdcall;
  TTestCallstdW = procedure(f_Text: PWideChar); stdcall;
  TTestCallcdelA = procedure(f_Text: PAnsiChar); cdecl;
  TTestCallcdelW = procedure(f_Text: PWideChar); cdecl;

  TForm1 = class(TForm)
    BtnFileCAll: TButton;
    BtnMemCall: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnFileCAllClick(Sender: TObject);
    procedure BtnMemCallClick(Sender: TObject);
  private
    m_TestCallstdA: TTestCallstdA;
    m_TestCallstdW: TTestCallstdW;
    m_TestCallcdelA: TTestCallcdelA;
    m_TestCallcdelW: TTestCallcdelW;
    mp_DllData: Pointer;
    m_DllDataSize: Integer;
    mp_MemoryModule: PBTMemoryModule;
    m_DllHandle: Cardinal;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;


implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  MemoryStream: TMemoryStream;
begin
  Position := poScreenCenter;
  MemoryStream := TMemoryStream.Create;
  MemoryStream.LoadFromFile('DemoDLL.dll');
  MemoryStream.Position := 0;
  m_DllDataSize := MemoryStream.Size;
  mp_DllData := GetMemory(m_DllDataSize);
  MemoryStream.Read(mp_DllData^, m_DllDataSize);
  MemoryStream.Free;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeMemory(mp_DllData);
end;

procedure TForm1.BtnFileCAllClick(Sender: TObject);
begin
  m_DllHandle := LoadLibrary('DemoDLL.dll');
  try
    if m_DllHandle = 0 then
      Abort;
    @m_TestCallstdA := GetProcAddress(m_DllHandle, 'TestCallstdA');
    if @m_TestCallstdA = nil then
      Abort;
    @m_TestCallstdW := GetProcAddress(m_DllHandle, 'TestCallstdW');
    if @m_TestCallstdW = nil then
      Abort;
    @m_TestCallcdelA := GetProcAddress(m_DllHandle, 'TestCallcdelA');
    if @m_TestCallcdelA = nil then
      Abort;
    @m_TestCallcdelW := GetProcAddress(m_DllHandle, 'TestCallcdelW');
    if @m_TestCallcdelW = nil then
      Abort;
    m_TestCallstdA('This is a Dll File call!');
    m_TestCallstdW('This is a Dll File call!');
    m_TestCallcdelA('This is a Dll File call!');
    m_TestCallcdelW('This is a Dll File call!');
  except
    Showmessage('An error occoured while loading the dll');
  end;
  if m_DllHandle <> 0 then
    FreeLibrary(m_DllHandle)
end;

procedure TForm1.BtnMemCallClick(Sender: TObject);
begin
  mp_MemoryModule := BTMemoryLoadLibary(mp_DllData, m_DllDataSize);
  try
    if mp_MemoryModule = nil then
      Abort;
    @m_TestCallstdA := BTMemoryGetProcAddress(mp_MemoryModule, 'TestCallstdA');
    if @m_TestCallstdA = nil then
      Abort;
    @m_TestCallstdW := BTMemoryGetProcAddress(mp_MemoryModule, 'TestCallstdW');
    if @m_TestCallstdW = nil then
      Abort;
    @m_TestCallcdelA := BTMemoryGetProcAddress(mp_MemoryModule, 'TestCallcdelA');
    if @m_TestCallcdelA = nil then
      Abort;
    @m_TestCallcdelW := BTMemoryGetProcAddress(mp_MemoryModule, 'TestCallcdelW');
    if @m_TestCallcdelW = nil then
      Abort;
    m_TestCallstdA('This is a Dll Memory call!');
    m_TestCallstdW('This is a Dll Memory call!');
    m_TestCallcdelA('This is a Dll Memory call!');
    m_TestCallcdelW('This is a Dll Memory call!');
  except
    Showmessage('An error occoured while loading the dll: ' +
      BTMemoryGetLastError);
  end;
  if mp_MemoryModule <> nil then
    BTMemoryFreeLibrary(mp_MemoryModule);
end;


end.

