library DemoDLL;

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

uses
  windows;

procedure TestCallstdA(f_Text: PAnsiChar); stdcall;
begin
  MessageBoxA(0, f_Text, 'Dll Dialog Ansi (stdcall)', 0);
end;

procedure TestCallstdW(f_Text: PWideChar); stdcall;
begin
  MessageBoxW(0, f_Text, 'Dll Dialog Unicode (stdcall)', 0);
end;

procedure TestCallcdelA(f_Text: PAnsiChar); cdecl;
begin
  MessageBoxA(0, f_Text, 'Dll Dialog Ansi (cdecl)', 0);
end;

procedure TestCallcdelW(f_Text: PWideChar); cdecl;
begin
  MessageBoxW(0, f_Text, 'Dll Dialog Unicode (cdecl)', 0);
end;


exports
  TestCallstdA,
  TestCallstdW,
  TestCallcdelA,
  TestCallcdelW;

begin
end.

