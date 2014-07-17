pascal-sqlite3
==============

Pascal interface for SQLite 3.7.3

Examples
--------

```pascal
unit test_sqlite3;
uses
	Windows, Messages, SysUtils, Variants, Classes, SQLite;

implementation

var
	db       : sqlite3 = nil;
	db_err   : Integer;
	db_errmsg: PChar;
	zErrMsg  : PChar;

procedure open_db();
begin
	if( db <> nil )then
		sqlite3_close( db );
	db_err    := SQLITE_OK;
	db_errmsg := nil;
	db        := nil;
	
	db_err := sqlite3_open( PChar(AnsiToUtf8('db.sqlite')), db );
	if( db_err <> SQLITE_OK )then
	begin
		FreeMemory( db_errmsg );
		db_errmsg := sqlite3_errmsg( db );
		sqlite3_close( db );
		MessageBox( Self.Handle, 'Error while open database!', 'Error', MB_OK + MB_ICONERROR );
		db := nil;
		Exit;
	end;
end;

procedure exec_query();
begin
	db_err := sqlite3_exec( db, 'CREATE TABLE IF NOT EXISTS Persons ( ID INTEGER PRIMARY KEY AUTOINCREMENT, Sex INT(1) DEFAULT 0, Name VARCHAR(50) )', nil, nil, zErrMsg );
	if( db_err <> SQLITE_OK )then
	begin
		FreeMemory( db_errmsg );
		db_errmsg := zErrMsg;
		MessageBox( Self.Handle, PChar('Create table error!' + #13 + db_errmsg), 'Error', MB_OK + MB_ICONERROR );
		Exit;
	end;
end;

procedure select_query();
var
	rows, cols: Integer;
	data: sqlite3_ppchar_arr;
	i: Integer;
begin
	db_err := sqlite3_get_table( db, PChar('SELECT ID, Sex, Name FROM Persons'), data, rows, cols, zErrMsg );
	if( db_err <> SQLITE_OK )then
	begin
		FreeMemory( db_errmsg );
		db_errmsg := zErrMsg;
		MessageBox( Self.Handle, PChar('Reading data error!' + #13 + db_errmsg), 'Error', MB_ICONERROR + MB_OK );
		Exit;
	end;
	for i:= 0 to rows-1 do
	begin
		// StrToInt(data^[ (i+1)*cols   ]) -> ID
		// StrToInt(data^[ (i+1)*cols+1 ]) -> Sex
		// PChar(Utf8ToAnsi(data^[ (i+1)*cols+2 ]) -> Name
	end;
	sqlite3_free_table( data );
end;

end.
```
