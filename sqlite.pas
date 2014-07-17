(*
	$Id: sqlite.pas 0002 2010/07/31 14:40:24 Sergey Yarkin $

	Description:	Pascal interface for SQLite free database engine v.3
	Started:	2009/11/07 15:57:10 by Sergey Yarkin
	SQLite ver.:	3.7.3
	Dependences:	sqlite3.dll (msvcrt.dll)
*)

unit sqlite;
interface

const
	SQLITE_DLL		= 'sqlite3.dll';

	(** Compile-Time Library Version Numbers **)
	SQLITE_VERSION		= '3.7.3';
	SQLITE_VERSION_NUMBER	= 3007003;
	SQLITE_SOURCE_ID	= '2010-10-08 02:34:02 2677848087c9c090efb17c1893e77d6136a9111d';

	(** Result codes **)
	SQLITE_OK		= $00;	// Successful result
	SQLITE_ERROR		= $01;	// SQL error or missing database
	SQLITE_INTERNAL		= $02;	// Internal logic error in SQLite
	SQLITE_PERM		= $03;	// Access permission denied
	SQLITE_ABORT		= $04;	// Callback routine requested an abort
	SQLITE_BUSY		= $05;	// The database file is locked
	SQLITE_LOCKED		= $06;	// A table in the database is locked
	SQLITE_NOMEM		= $07;	// A malloc() failed
	SQLITE_READONLY		= $08;	// Attempt to write a readonly database
	SQLITE_INTERRUPT	= $09;	// Operation terminated by sqlite3_interrupt()
	SQLITE_IOERR		= $0A;	// Some kind of disk I/O error occurred
	SQLITE_CORRUPT		= $0B;	// The database disk image is malformed
	SQLITE_NOTFOUND		= $0C;	// NOT USED. Table or record not found
	SQLITE_FULL		= $0D;	// Insertion failed because database is full
	SQLITE_CANTOPEN		= $0E;	// Unable to open the database file
	SQLITE_PROTOCOL		= $0F;	// NOT USED. Database lock protocol error
	SQLITE_EMPTY		= $10;	// Database is empty
	SQLITE_SCHEMA		= $11;	// The database schema changed
	SQLITE_TOOBIG		= $12;	// String or BLOB exceeds size limit
	SQLITE_CONSTRAINT	= $13;	// Abort due to constraint violation
	SQLITE_MISMATCH		= $14;	// Data type mismatch
	SQLITE_MISUSE		= $15;	// Library used incorrectly
	SQLITE_NOLFS		= $16;	// Uses OS features not supported on host
	SQLITE_AUTH		= $17;	// Authorization denied
	SQLITE_FORMAT		= $18;	// Auxiliary database format error
	SQLITE_RANGE		= $19;	// 2nd parameter to sqlite3_bind out of range
	SQLITE_NOTADB		= $1A;	// File opened that is not a database file
	SQLITE_ROW		= $64;	// sqlite3_step() has another row ready
	SQLITE_DONE		= $65;	// sqlite3_step() has finished executing

	(** Extended result codes **)
	// Disk I/O errors
	SQLITE_IOERR_READ		= SQLITE_IOERR or ($01 shl $08);
	SQLITE_IOERR_SHORT_READ		= SQLITE_IOERR or ($02 shl $08);
	SQLITE_IOERR_WRITE		= SQLITE_IOERR or ($03 shl $08);
	SQLITE_IOERR_FSYNC		= SQLITE_IOERR or ($04 shl $08);
	SQLITE_IOERR_DIR_FSYNC		= SQLITE_IOERR or ($05 shl $08);
	SQLITE_IOERR_TRUNCATE		= SQLITE_IOERR or ($06 shl $08);
	SQLITE_IOERR_FSTAT		= SQLITE_IOERR or ($07 shl $08);
	SQLITE_IOERR_UNLOCK		= SQLITE_IOERR or ($08 shl $08);
	SQLITE_IOERR_RDLOCK		= SQLITE_IOERR or ($09 shl $08);
	SQLITE_IOERR_DELETE		= SQLITE_IOERR or ($0A shl $08);
	SQLITE_IOERR_BLOCKED		= SQLITE_IOERR or ($0B shl $08);
	SQLITE_IOERR_NOMEM		= SQLITE_IOERR or ($0C shl $08);
	SQLITE_IOERR_ACCESS		= SQLITE_IOERR or ($0D shl $08);
	SQLITE_IOERR_CHECKRESERVEDLOCK	= SQLITE_IOERR or ($0E shl $08);
	SQLITE_IOERR_LOCK		= SQLITE_IOERR or ($0F shl $08);
	SQLITE_IOERR_CLOSE		= SQLITE_IOERR or ($10 shl $08);
	SQLITE_IOERR_DIR_CLOSE		= SQLITE_IOERR or ($11 shl $08);
	SQLITE_IOERR_SHMOPEN		= SQLITE_IOERR or ($12 shl $08);
	SQLITE_IOERR_SHMSIZE		= SQLITE_IOERR or ($13 shl $08);
	SQLITE_IOERR_SHMLOCK		= SQLITE_IOERR or ($14 shl $08);
	SQLITE_LOCKED_SHAREDCACHE	= SQLITE_LOCKED or ($01 shl $08);
	SQLITE_BUSY_RECOVERY		= SQLITE_BUSY or ($01 shl $08);
	SQLITE_CANTOPEN_NOTEMPDIR	= SQLITE_CANTOPEN or ($01 shl $08);

	(** Flags For File Open Operations **)
	SQLITE_OPEN_READONLY		= $000001;  // Ok for sqlite3_open_v2()
	SQLITE_OPEN_READWRITE		= $000002;  // Ok for sqlite3_open_v2()
	SQLITE_OPEN_CREATE		= $000004;  // Ok for sqlite3_open_v2()
	SQLITE_OPEN_DELETEONCLOSE	= $000008;  // VFS only
	SQLITE_OPEN_EXCLUSIVE		= $000010;  // VFS only
	SQLITE_OPEN_MAIN_DB		= $000100;  // VFS only
	SQLITE_OPEN_TEMP_DB		= $000200;  // VFS only
	SQLITE_OPEN_TRANSIENT_DB	= $000400;  // VFS only
	SQLITE_OPEN_MAIN_JOURNAL	= $000800;  // VFS only
	SQLITE_OPEN_TEMP_JOURNAL	= $001000;  // VFS only
	SQLITE_OPEN_SUBJOURNAL		= $002000;  // VFS only
	SQLITE_OPEN_MASTER_JOURNAL	= $004000;  // VFS only
	SQLITE_OPEN_NOMUTEX		= $008000;  // Ok for sqlite3_open_v2()
	SQLITE_OPEN_FULLMUTEX		= $010000;  // Ok for sqlite3_open_v2()
	SQLITE_OPEN_SHAREDCACHE		= $020000;  // Ok for sqlite3_open_v2()
	SQLITE_OPEN_PRIVATECACHE	= $040000;  // Ok for sqlite3_open_v2()
	SQLITE_OPEN_WAL			= $080000;  // VFS only

	(** Device Characteristics **)
	SQLITE_IOCAP_ATOMIC			= $0001;
	SQLITE_IOCAP_ATOMIC512			= $0002;
	SQLITE_IOCAP_ATOMIC1K			= $0004;
	SQLITE_IOCAP_ATOMIC2K			= $0008;
	SQLITE_IOCAP_ATOMIC4K			= $0010;
	SQLITE_IOCAP_ATOMIC8K			= $0020;
	SQLITE_IOCAP_ATOMIC16K			= $0040;
	SQLITE_IOCAP_ATOMIC32K			= $0080;
	SQLITE_IOCAP_ATOMIC64K			= $0100;
	SQLITE_IOCAP_SAFE_APPEND		= $0200;
	SQLITE_IOCAP_SEQUENTIAL			= $0400;
	SQLITE_IOCAP_UNDELETABLE_WHEN_OPEN	= $0800;

	(** File Locking Levels **)
	SQLITE_LOCK_NONE	= $00;
	SQLITE_LOCK_SHARED	= $01;
	SQLITE_LOCK_RESERVED	= $02;
	SQLITE_LOCK_PENDING	= $03;
	SQLITE_LOCK_EXCLUSIVE	= $04;

	(** Synchronization Type Flags **)
	SQLITE_SYNC_NORMAL	= $02;
	SQLITE_SYNC_FULL	= $03;
	SQLITE_SYNC_DATAONLY	= $10;

	(** Standard File Control Opcodes **)
	SQLITE_FCNTL_LOCKSTATE		= $01;
	SQLITE_GET_LOCKPROXYFILE	= $02;
	SQLITE_SET_LOCKPROXYFILE	= $03;
	SQLITE_LAST_ERRNO		= $04;
	SQLITE_FCNTL_SIZE_HINT		= $05;
	SQLITE_FCNTL_CHUNK_SIZE		= $06;

	(** Flags for the xAccess VFS method **)
	SQLITE_ACCESS_EXISTS	= $00;	// Checks whether the file exists
	SQLITE_ACCESS_READWRITE	= $01;	// Checks whether the file is both readable and writable
	SQLITE_ACCESS_READ	= $02;	// Checks whether the file is readable

	(** Flags for the xShmLock VFS method **)
	SQLITE_SHM_UNLOCK	= $01;
	SQLITE_SHM_LOCK		= $02;
	SQLITE_SHM_SHARED	= $04;
	SQLITE_SHM_EXCLUSIVE	= $08;

	(** Maximum xShmLock index **)
	SQLITE_SHM_NLOCK	= $08;

	(** Configuration Options **)
	SQLITE_CONFIG_SINGLETHREAD	= $01;	// nil
	SQLITE_CONFIG_MULTITHREAD	= $02;	// nil
	SQLITE_CONFIG_SERIALIZED	= $03;	// nil
	SQLITE_CONFIG_MALLOC		= $04;	// sqlite3_mem_methods*
	SQLITE_CONFIG_GETMALLOC		= $05;	// sqlite3_mem_methods*
	SQLITE_CONFIG_SCRATCH		= $06;	// void*, int sz, int N
	SQLITE_CONFIG_PAGECACHE		= $07;	// void*, int sz, int N
	SQLITE_CONFIG_HEAP		= $08;	// void*, int nByte, int min
	SQLITE_CONFIG_MEMSTATUS		= $09;	// boolean
	SQLITE_CONFIG_MUTEX		= $0A;	// sqlite3_mutex_methods*
	SQLITE_CONFIG_GETMUTEX		= $0B;	// sqlite3_mutex_methods*
	//SQLITE_CONFIG_CHUNKALLOC	= $0C;	// Now is unused
	SQLITE_CONFIG_LOOKASIDE		= $0D;	// int int
	SQLITE_CONFIG_PCACHE		= $0E;	// sqlite3_pcache_methods*
	SQLITE_CONFIG_GETPCACHE		= $0F;	// sqlite3_pcache_methods*
	SQLITE_CONFIG_LOG		= $10;	// xFunc, void*

	(** Database Connection Configuration Options **)
	SQLITE_DBCONFIG_LOOKASIDE	= $03E9;// void* int int

	(** Authorizer Return Codes **)
	SQLITE_DENY			= $01;	// Abort the SQL statement with an error
	SQLITE_IGNORE			= $02;	// Don't allow access, but don't generate an error

	(** Authorizer Action Codes **)
	(******************************************* 3rd **************** 4th **********)
	SQLITE_CREATE_INDEX		= $01;	// Index Name		Table Name
	SQLITE_CREATE_TABLE		= $02;	// Table Name		NULL
	SQLITE_CREATE_TEMP_INDEX	= $03;	// Index Name		Table Name
	SQLITE_CREATE_TEMP_TABLE	= $04;	// Table Name		NULL
	SQLITE_CREATE_TEMP_TRIGGER	= $05;	// Trigger Name		Table Name
	SQLITE_CREATE_TEMP_VIEW		= $06;	// View Name		NULL
	SQLITE_CREATE_TRIGGER		= $07;	// Trigger Name		Table Name
	SQLITE_CREATE_VIEW		= $08;	// View Name		NULL
	SQLITE_DELETE			= $09;	// Table Name		NULL
	SQLITE_DROP_INDEX		= $0A;	// Index Name		Table Name
	SQLITE_DROP_TABLE		= $0B;	// Table Name		NULL
	SQLITE_DROP_TEMP_INDEX		= $0C;	// Index Name		Table Name
	SQLITE_DROP_TEMP_TABLE		= $0D;	// Table Name		NULL
	SQLITE_DROP_TEMP_TRIGGER	= $0E;	// Trigger Name		Table Name
	SQLITE_DROP_TEMP_VIEW		= $0F;	// View Name		NULL
	SQLITE_DROP_TRIGGER		= $10;	// Trigger Name		able Name
	SQLITE_DROP_VIEW		= $11;	// View Name		NULL
	SQLITE_INSERT			= $12;	// Table Name		NULL
	SQLITE_PRAGMA			= $13;	// Pragma Name		1st arg or NULL
	SQLITE_READ			= $14;	// Table Name		Column Name
	SQLITE_SELECT			= $15;	// NULL			NULL
	SQLITE_TRANSACTION		= $16;	// Operation		NULL
	SQLITE_UPDATE			= $17;	// Table Name		Column Name
	SQLITE_ATTACH			= $18;	// Filename		NULL
	SQLITE_DETACH			= $19;	// Database Name	NULL
	SQLITE_ALTER_TABLE		= $1A;	// Database Name	Table Name
	SQLITE_REINDEX			= $1B;	// Index Name		NULL
	SQLITE_ANALYZE			= $1C;	// Table Name		NULL
	SQLITE_CREATE_VTABLE		= $1D;	// Table Name		Module Name
	SQLITE_DROP_VTABLE		= $1E;	// Table Name		Module Name
	SQLITE_FUNCTION			= $1F;	// NULL			Function Name
	SQLITE_SAVEPOINT		= $20;	// Operation		Savepoint Name
	SQLITE_COPY			= $00;	// No longer used

	(** Run-Time Limit Categories **)
	SQLITE_LIMIT_LENGTH			= $00;
	SQLITE_LIMIT_SQL_LENGTH			= $01;
	SQLITE_LIMIT_COLUMN			= $02;
	SQLITE_LIMIT_EXPR_DEPTH			= $03;
	SQLITE_LIMIT_COMPOUND_SELECT		= $04;
	SQLITE_LIMIT_VDBE_OP			= $05;
	SQLITE_LIMIT_FUNCTION_ARG		= $06;
	SQLITE_LIMIT_ATTACHED			= $07;
	SQLITE_LIMIT_LIKE_PATTERN_LENGTH	= $08;
	SQLITE_LIMIT_VARIABLE_NUMBER		= $09;
	SQLITE_LIMIT_TRIGGER_DEPTH		= $0A;

	(** Fundamental Datatypes **)
	SQLITE_INTEGER	= $01;	// 64-bit signed integer
	SQLITE_FLOAT	= $02;	// 64-bit IEEE floating point number
	SQLITE_TEXT	= $03;	// String
	SQLITE3_TEXT	= $03;	// Also string
	SQLITE_BLOB	= $04;	// BLOB
	SQLITE_NULL	= $05;	// NULL

	(** Text Encodings **)
	SQLITE_UTF8		= $01;
	SQLITE_UTF16LE		= $02;
	SQLITE_UTF16BE		= $03;
	SQLITE_UTF16		= $04;	// Use native byte order
	SQLITE_ANY		= $05;	// sqlite3_create_function only
	SQLITE_UTF16_ALIGNED	= $08;	// sqlite3_create_collation only

	(** Constants Defining Special Destructor Behavior **)
	SQLITE_STATIC		= Cardinal( 0);
	SQLITE_TRANSIENT	= Cardinal(-1);

	(** Virtual Table Indexing Information **)
	SQLITE_INDEX_CONSTRAINT_EQ	= $02;
	SQLITE_INDEX_CONSTRAINT_GT	= $04;
	SQLITE_INDEX_CONSTRAINT_LE	= $08;
	SQLITE_INDEX_CONSTRAINT_LT	= $10;
	SQLITE_INDEX_CONSTRAINT_GE	= $20;
	SQLITE_INDEX_CONSTRAINT_MATCH	= $40;

	(** Mutex Types **)
	SQLITE_MUTEX_FAST		= $00;
	SQLITE_MUTEX_RECURSIVE		= $01;
	SQLITE_MUTEX_STATIC_MASTER	= $02;
	SQLITE_MUTEX_STATIC_MEM		= $03;	// sqlite3_malloc()
	SQLITE_MUTEX_STATIC_MEM2	= $04;	// NOT USED
	SQLITE_MUTEX_STATIC_OPEN	= $04;	// sqlite3BtreeOpen()
	SQLITE_MUTEX_STATIC_PRNG	= $05;	// sqlite3_random()
	SQLITE_MUTEX_STATIC_LRU		= $06;	// lru page list
	SQLITE_MUTEX_STATIC_LRU2	= $07;	// lru page list

	(** Testing Interface Operation Codes **)
	SQLITE_TESTCTRL_FIRST			= $05;
	SQLITE_TESTCTRL_PRNG_SAVE		= $05;
	SQLITE_TESTCTRL_PRNG_RESTORE		= $06;
	SQLITE_TESTCTRL_PRNG_RESET		= $07;
	SQLITE_TESTCTRL_BITVEC_TEST		= $08;
	SQLITE_TESTCTRL_FAULT_INSTALL		= $09;
	SQLITE_TESTCTRL_BENIGN_MALLOC_HOOKS	= $0A;
	SQLITE_TESTCTRL_PENDING_BYTE		= $0B;
	SQLITE_TESTCTRL_ASSERT			= $0C;
	SQLITE_TESTCTRL_ALWAYS			= $0D;
	SQLITE_TESTCTRL_RESERVE			= $0E;
	SQLITE_TESTCTRL_OPTIMIZATIONS		= $0F;
	SQLITE_TESTCTRL_ISKEYWORD		= $10;
	SQLITE_TESTCTRL_PGHDRSZ			= $11;
	SQLITE_TESTCTRL_LAST			= $11;

	(** Status Parameters **)
	SQLITE_STATUS_MEMORY_USED		= $00;
	SQLITE_STATUS_PAGECACHE_USED		= $01;
	SQLITE_STATUS_PAGECACHE_OVERFLOW	= $02;
	SQLITE_STATUS_SCRATCH_USED		= $03;
	SQLITE_STATUS_SCRATCH_OVERFLOW		= $04;
	SQLITE_STATUS_MALLOC_SIZE		= $05;
	SQLITE_STATUS_PARSER_STACK		= $06;
	SQLITE_STATUS_PAGECACHE_SIZE		= $07;
	SQLITE_STATUS_SCRATCH_SIZE		= $08;

	(** Status Parameters for database connections **)
	SQLITE_DBSTATUS_LOOKASIDE_USED	= $00;
	SQLITE_DBSTATUS_CACHE_USED	= $01;
	SQLITE_DBSTATUS_SCHEMA_USED	= $02;
	SQLITE_DBSTATUS_STMT_USED	= $03;
	SQLITE_DBSTATUS_MAX		= $03;

	(** Status Parameters for prepared statements **)
	SQLITE_STMTSTATUS_FULLSCAN_STEP	= $01;
	SQLITE_STMTSTATUS_SORT		= $02;
	SQLITE_STMTSTATUS_AUTOINDEX	= $03;


type
	sqlite3 = Pointer;
	sqlite3_stmt = Pointer;
	sqlite3_backup = Pointer;
	sqlite3_context = Pointer;
	PPChar = ^PChar;
	sqlite3_func = Pointer;
	sqlite3_blob = Pointer;
	sqlite3_value = Pointer;
	sqlite3_mutex = Pointer;
	//sqlite3_vfs = Pointer;
	sqlite3_pchar_arr = Array[$00..High(Word)-1] Of PChar;
	sqlite3_ppchar_arr = ^sqlite3_pchar_arr;
	sqlite3_int64 = Int64;
	sqlite3_uint64 = Int64;

	psqlite3_vfs = ^sqlite3_vfs;
	sqlite3_vfs = record
		iVersion: Integer;	// Structure version number (currently 2)
		szOsFile: Integer; 	// Size of subclassed sqlite3_file
		mxPathname: Integer;	// Maximum file pathname length
		pNext: psqlite3_vfs;	// Next registered VFS
		zName: PChar;		// Name of this virtual file system
		pAppData: Pointer;	// Pointer to application-specific data
		xOpen: sqlite3_func;
		{	 int xOpen( sqlite3_vfs*, char *zName, sqlite3_file*, int flags, int *pOutFlags);	}
		xDelete: sqlite3_func;
		{	int xDelete( sqlite3_vfs*, char *zName, int syncDir );	}
		xAccess: sqlite3_func;
		{	int xAccess( sqlite3_vfs*, char *zName, int flags, int *pResOut );	}
		xFullPathname: sqlite3_func;
		{	int xFullPathname( sqlite3_vfs*, char *zName, int nOut, char *zOut );	}
		xDlOpen: sqlite3_func;
		{	void* xDlOpen( sqlite3_vfs*, char *zFilename );	}
		xDlError: sqlite3_func;
		{	void xDlError( sqlite3_vfs*, int nByte, char *zErrMsg );	}
		xDlSym: sqlite3_func;
		{	void* xDlSym( sqlite3_vfs*, void*, const char *zSymbol );	}
		xDlClose: sqlite3_func;
		{	void xDlClose( sqlite3_vfs*, void* );	}
		xRandomness: sqlite3_func;
		{	int xRandomness( sqlite3_vfs*, int nByte, char *zOut );	}
		xSleep: sqlite3_func;
		{	int xSleep( sqlite3_vfs*, int microseconds ); }
		xCurrentTime: sqlite3_func;
		{	int xCurrentTime( sqlite3_vfs*, double* );	}
		xGetLastError: sqlite3_func;
		{	int xGetLastError( sqlite3_vfs*, int, char* );	}
		(* The methods above are in version 1 of the sqlite_vfs object definition.
		   Those that follow are added in version 2 or later *)
		xCurrentTimeInt64: sqlite3_func;
		{	int xCurrentTimeInt64( sqlite3_vfs*, sqlite3_int64* );	}
		(* The methods above are in versions 1 and 2 of the sqlite_vfs object.
		   New fields may be appended in figure versions. The iVersion value will
		   increment whenever this happens. *)
	end;

	(** Exported SQLite function **)
	function  sqlite3_aggregate_context( context: sqlite3_context; nBytes: Integer ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_aggregate_context';
	function  sqlite3_aggregate_count( context: sqlite3_context ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_aggregate_count';
	function  sqlite3_auto_extension( xInit: sqlite3_func ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_auto_extension';
	{	void xInit( void )	}
	function  sqlite3_backup_finish( backup: sqlite3_backup ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_backup_finish';
	function  sqlite3_backup_init( pDest: sqlite3; zDestName: PChar; pSource: sqlite3; zSourceName: PChar ): sqlite3_backup; cdecl; external SQLITE_DLL name 'sqlite3_backup_init';
	function  sqlite3_backup_pagecount( backup: sqlite3_backup ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_backup_pagecount';
	function  sqlite3_backup_remaining( backup: sqlite3_backup ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_backup_remaining';
	function  sqlite3_backup_step( backup: sqlite3_backup; nPage: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_backup_step';
	function  sqlite3_bind_blob( pStmt: sqlite3_stmt; i: Integer; zData: Pointer; nData: Integer; xDel: sqlite3_func ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_bind_blob';
	{	void xDel( void* )	}
	function  sqlite3_bind_double( pStmt: sqlite3_stmt; i: Integer; rValue: Double ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_bind_double'; 
	function  sqlite3_bind_int( pStmt: sqlite3_stmt; i: Integer; iValue: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_bind_int'; 
	function  sqlite3_bind_int64( pStmt: sqlite3_stmt; i: Integer; iValue: sqlite3_int64 ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_bind_int64'; 
	function  sqlite3_bind_null( pStmt: sqlite3_stmt; i: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_bind_null';
	function  sqlite3_bind_parameter_count( pStmt: sqlite3_stmt ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_bind_parameter_count';
	function  sqlite3_bind_parameter_index( pStmt: sqlite3_stmt ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_bind_parameter_index';
	function  sqlite3_bind_parameter_name( pStmt: sqlite3_stmt; i: Integer ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_bind_parameter_name';
	function  sqlite3_bind_text( pStmt: sqlite3_stmt; i: Integer; zData: Pointer; nData: Integer; xDel: sqlite3_func ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_bind_text';
	{	void xDel( void* )	}
	function  sqlite3_bind_text16( pStmt: sqlite3_stmt; i: Integer; zData: Pointer; nData: Integer; xDel: sqlite3_func ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_bind_text16';
	{	void xDel( void* )	}
	function  sqlite3_bind_value( pStmt: sqlite3_stmt; i: Integer; pValue: Pointer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_bind_value';
	function  sqlite3_bind_zeroblob( pStmt: sqlite3_stmt; i: Integer; n: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_bind_zeroblob';
	function  sqlite3_blob_bytes( pBlob: sqlite3_blob ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_blob_bytes';
	function  sqlite3_blob_close( pBlob: sqlite3_blob ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_blob_close';
	function  sqlite3_blob_open( db: sqlite3; zDb: PChar; zTable: PChar; zColumn: PChar; iRow: sqlite3_int64; flags: Integer; var ppBlob: sqlite3_blob ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_blob_open';
	function  sqlite3_blob_read( pBlob: sqlite3_blob; z: Pointer; n: Integer; iOffset: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_blob_read';
	function  sqlite3_blob_write( pBlob: sqlite3_blob; z: Pointer; n: Integer; iOffset: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_blob_write';
	function  sqlite3_busy_handler( db: sqlite3; xBusy: sqlite3_func; pArg: Pointer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_busy_handler';
	{	int  xBusy( void*, int )	}
	function  sqlite3_busy_timeout( db: sqlite3; ms: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_busy_timeout';
	function  sqlite3_changes( db: sqlite3 ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_changes';
	function  sqlite3_clear_bindings( pStmt: sqlite3_stmt ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_clear_bindings';
	function  sqlite3_close( db: sqlite3 ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_close';
	function  sqlite3_collation_needed( db: sqlite3; pCollNeededArg: Pointer; xCollNeeded: sqlite3_func ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_collation_needed';
	{	void xCollNeeded( void*, sqlite3*, int, char* )	}
	function  sqlite3_collation_needed16( db: sqlite3; pCollNeededArg: Pointer; xCollNeeded16: sqlite3_func ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_collation_needed16';
	{	void xCollNeeded16( void*, sqlite3*, int, void* )	}
	function  sqlite3_column_blob( pStmt: sqlite3_stmt; i: Integer ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_column_blob';
	function  sqlite3_column_bytes( pStmt: sqlite3_stmt; i: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_column_bytes';
	function  sqlite3_column_bytes16( pStmt: sqlite3_stmt; i: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_column_bytes16';
	function  sqlite3_column_count( pStmt: sqlite3_stmt ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_column_count';
	function  sqlite3_column_database_name( pStmt: sqlite3_stmt; N: Integer ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_column_database_name';
	function  sqlite3_column_database_name16( pStmt: sqlite3_stmt; N: Integer ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_column_database_name16';
	function  sqlite3_column_decltype( pStmt: sqlite3_stmt; N: Integer ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_column_decltype';
	function  sqlite3_column_decltype16( pStmt: sqlite3_stmt; N: Integer ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_column_decltype16';
	function  sqlite3_column_double( pStmt: sqlite3_stmt; i: Integer ): Double; cdecl; external SQLITE_DLL name 'sqlite3_column_double';
	function  sqlite3_column_int( pStmt: sqlite3_stmt; i: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_column_int';
	function  sqlite3_column_int64( pStmt: sqlite3_stmt; i: Integer ): sqlite3_int64; cdecl; external SQLITE_DLL name 'sqlite3_column_int64';
	function  sqlite3_column_name( pStmt: sqlite3_stmt; N: Integer ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_column_name';
	function  sqlite3_column_name16( pStmt: sqlite3_stmt; N: Integer ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_column_name16';
	function  sqlite3_column_origin_name( pStmt: sqlite3_stmt; N: Integer ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_column_origin_name';
	function  sqlite3_column_origin_name16( pStmt: sqlite3_stmt; N: Integer ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_column_origin_name16';
	function  sqlite3_column_table_name( pStmt: sqlite3_stmt; N: Integer ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_column_table_name';
	function  sqlite3_column_table_name16( pStmt: sqlite3_stmt; N: Integer ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_column_table_name16';
	function  sqlite3_column_text( pStmt: sqlite3_stmt; i: Integer ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_column_text';
	function  sqlite3_column_text16( pStmt: sqlite3_stmt; i: Integer ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_column_text16';
	function  sqlite3_column_type( pStmt: sqlite3_stmt; i: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_column_type';
	function  sqlite3_column_value( pStmt: sqlite3_stmt; i: Integer ): sqlite3_value; cdecl; external SQLITE_DLL name 'sqlite3_column_value';
	function  sqlite3_commit_hook( db: sqlite3; xCallback: sqlite3_func; pArg: Pointer ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_commit_hook';
	{	int  xCallback( void* )	}
	function  sqlite3_compileoption_get( N: Integer ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_compileoption_get';
	function  sqlite3_compileoption_used( zOptName: PChar ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_compileoption_used';
	function  sqlite3_complete( zSql: PChar ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_complete';
	function  sqlite3_complete16( zSql: PChar ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_complete16';
	function  sqlite3_config( op: Integer; x: array of const ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_config';
	function  sqlite3_context_db_handle( p: Pointer ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_context_db_handle';
	function  sqlite3_create_collation( db: sqlite3; zName: PChar; enc: Integer; pCtx: sqlite3_context; xCompare: sqlite3_func ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_create_collation';
	function  sqlite3_create_collation16( db: sqlite3; zName: PChar; enc: Integer; pCtx: sqlite3_context; xCompare: sqlite3_func ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_create_collation16';
	function  sqlite3_create_collation_v2( db: sqlite3; zName: PChar; enc: Integer; pCtx: sqlite3_context; xCompare: sqlite3_func; xDel: sqlite3_func ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_create_collation_v2';
	{	int  xCompare( void*, int, void*, int, void* )	}
	function  sqlite3_create_function( db: sqlite3; zFunctionName: PChar; nArg: Integer; enc: Integer; p: Pointer; xFunc: sqlite3_func; xStep: sqlite3_func; xFinal: sqlite3_func ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_create_function';
	function  sqlite3_create_function16( db: sqlite3; zFunctionName: PChar; nArg: Integer; enc: Integer; p: Pointer; xFunc: sqlite3_func; xStep: sqlite3_func; xFinal: sqlite3_func ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_create_function16';
	function  sqlite3_create_function_v2( db: sqlite3; zFunctionName: PChar; nArg: Integer; enc: Integer; p: Pointer; xFunc: sqlite3_func; xStep: sqlite3_func; xFinal: sqlite3_func; xDestroy: sqlite3_func ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_create_function_v2';
	{	void xFunc( sqlite3_context*, int, sqlite3_value** )
		void xStep( sqlite3_context*, int, sqlite3_value** )
		void xFinal( sqlite3_context* )
		void xDestroy( void* )
	}
	function  sqlite3_create_module( db: sqlite3; zName: PChar; pModule: Pointer; pAux: Pointer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_create_module';
	function  sqlite3_create_module_v2( db: sqlite3; zName: PChar; pModule: Pointer; pAux: Pointer; xDestroy: sqlite3_func ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_create_module_v2';
	{	void xDestroy( void * )	}
	function  sqlite3_data_count( pStmt: sqlite3_stmt ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_data_count';
	function  sqlite3_db_config( db: sqlite3; op: Integer; x: array of const ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_db_config';
	function  sqlite3_db_handle( pStmt: sqlite3_stmt ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_db_handle';
	function  sqlite3_db_mutex( db: sqlite3 ): sqlite3_mutex; cdecl; external SQLITE_DLL name 'sqlite3_db_mutex';
	function  sqlite3_db_status( db: sqlite3; op: Integer; var pCurrent: Integer; var pHighwater: Integer; resetFlag: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_db_status';
	function  sqlite3_declare_vtab( db: sqlite3; zCreateTable: PChar ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_declare_vtab';
	function  sqlite3_enable_load_extension( db: sqlite3; onoff: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_enable_load_extension';
	function  sqlite3_enable_shared_cache( enable: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_enable_shared_cache';
	function  sqlite3_errcode( db: sqlite3 ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_errcode';
	function  sqlite3_errmsg( db: sqlite3 ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_errmsg';
	function  sqlite3_errmsg16( db: sqlite3 ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_errmsg16';
	function  sqlite3_exec( db: sqlite3; zSql: PChar; xCallback: sqlite3_func; pArg: Pointer; var pzErrMsg: PChar ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_exec';
	{	int xCallback( void*, int, char**, char** )	}
	function  sqlite3_expired( pStmt: sqlite3_stmt ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_expired';
	function  sqlite3_extended_errcode( db: sqlite3 ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_extended_errcode';
	function  sqlite3_extended_result_codes( db: sqlite3; onoff: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_extended_result_codes';
	function  sqlite3_file_control( db: sqlite3; zDbName: PChar; op: Integer; pArg: Pointer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_file_control';
	function  sqlite3_finalize( pStmt: sqlite3_stmt ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_finalize';
	procedure sqlite3_free( p: Pointer ); cdecl; external SQLITE_DLL name 'sqlite3_free';
	procedure sqlite3_free_table( azResult: sqlite3_ppchar_arr ); cdecl; external SQLITE_DLL name 'sqlite3_free_table';
	function  sqlite3_get_autocommit( db: sqlite3 ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_get_autocommit';
	function  sqlite3_get_auxdata( pCtx: sqlite3_context; iArg: Integer ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_get_auxdata';
	function  sqlite3_get_table( db: sqlite3; zSql: PChar; var pazResult: sqlite3_ppchar_arr; var pnRow: Integer; var pnColumn: Integer; var pzErrmsg: PChar ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_get_table';
	function  sqlite3_global_recover(): Integer; cdecl; external SQLITE_DLL name 'sqlite3_global_recover';
	function  sqlite3_initialize(): Integer; cdecl; external SQLITE_DLL name 'sqlite3_initialize';
	procedure sqlite3_interrupt( db: sqlite3 ); cdecl; external SQLITE_DLL name 'sqlite3_interrupt';
	function  sqlite3_last_insert_rowid( db: sqlite3 ): sqlite3_int64; cdecl; external SQLITE_DLL name 'sqlite3_last_insert_rowid';
	function  sqlite3_libversion(): PChar; cdecl; external SQLITE_DLL name 'sqlite3_libversion';
	function  sqlite3_libversion_number(): Integer; cdecl; external SQLITE_DLL name 'sqlite3_libversion_number';
	function  sqlite3_limit( db: sqlite3; limitId: Integer; newLimit: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_limit';
	function  sqlite3_load_extension( db: sqlite3; zFile: PChar; zProc: PChar; var pzErrMsg: PChar ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_load_extension';
	procedure sqlite3_log( iErrCode: Integer; zFormat: PChar; x: array of const ); cdecl; external SQLITE_DLL name 'sqlite3_log';
	function  sqlite3_malloc( n: Integer ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_malloc';
	function  sqlite3_memory_alarm( xCallback: sqlite3_func; pArg: Pointer; iThreshold: sqlite3_int64 ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_memory_alarm';
	{	void xCallback( void*, sqlite3_int64, int )	}
	function  sqlite3_memory_highwater( resetFlag: Integer ): sqlite3_int64; cdecl; external SQLITE_DLL name 'sqlite3_memory_highwater';
	function  sqlite3_memory_used(): sqlite3_int64; cdecl; external SQLITE_DLL name 'sqlite3_memory_used';
	function  sqlite3_mprintf( zFormat: PChar; x: array of const ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_mprintf';
	function  sqlite3_mutex_alloc( id: Integer ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_mutex_alloc';
	procedure sqlite3_mutex_enter( p: Pointer ); cdecl; external SQLITE_DLL name 'sqlite3_mutex_enter';
	procedure sqlite3_mutex_free( p: Pointer ); cdecl; external SQLITE_DLL name 'sqlite3_mutex_free';
	procedure sqlite3_mutex_leave( p: Pointer ); cdecl; external SQLITE_DLL name 'sqlite3_mutex_leave';
	function  sqlite3_mutex_try( p: Pointer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_mutex_try';
	function  sqlite3_next_stmt( pDb: sqlite3; pStmt: sqlite3_stmt ): sqlite3_stmt; cdecl; external SQLITE_DLL name 'sqlite3_next_stmt';
	function  sqlite3_open( filename: PChar; var ppDb: sqlite3 ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_open';
	function  sqlite3_open16( filename: PChar; var ppDb: sqlite3 ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_open16';
	function  sqlite3_open_v2( filename: PChar; var ppDb: sqlite3; flags: Integer; zVfs: PChar ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_open_v2';
	function  sqlite3_os_end(): Integer; cdecl; external SQLITE_DLL name 'sqlite3_os_end';
	function  sqlite3_os_init(): Integer; cdecl; external SQLITE_DLL name 'sqlite3_os_init';
	function  sqlite3_overload_function( db: sqlite3; zName: PChar; nArg: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_overload_function';
	function  sqlite3_prepare( db: sqlite3; zSql: PChar; nByte: Integer; var ppStmt: sqlite3_stmt; var pzTail: PChar ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_prepare';
	function  sqlite3_prepare16( db: sqlite3; zSql: PChar; nByte: Integer; var ppStmt: sqlite3_stmt; var pzTail: PChar ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_prepare16';
	function  sqlite3_prepare_v2( db: sqlite3; zSql: PChar; nByte: Integer; var ppStmt: sqlite3_stmt; var pzTail: PChar ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_prepare_v2';
	function  sqlite3_prepare16_v2( db: sqlite3; zSql: PChar; nByte: Integer; var ppStmt: sqlite3_stmt; var pzTail: PChar ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_prepare16_v2';
	function  sqlite3_profile( db: sqlite3; xProfile: sqlite3_func; pArg: Pointer ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_profile';
	{	void xProfile( void*, char*, sqlite_uint64 )	}
	procedure sqlite3_progress_handler( db: sqlite3; nOps: Integer; xProgress: sqlite3_func; pArg: Pointer ); cdecl; external SQLITE_DLL name 'sqlite3_progress_handler';
	{	int xProgress( void* )	}
	procedure sqlite3_randomness( N: Integer; pBuf: Pointer ); cdecl; external SQLITE_DLL name 'sqlite3_randomness';
	function  sqlite3_realloc( pOld: Pointer; n: Integer ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_realloc';
	function  sqlite3_release_memory( n: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_release_memory';
	function  sqlite3_reset( sqlite3_stmt: Pointer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_reset';
	procedure sqlite3_reset_auto_extension(); cdecl; external SQLITE_DLL name 'sqlite3_reset_auto_extension';
	procedure sqlite3_result_blob( pCtx: sqlite3_context; z: Pointer; n: Integer; xDel: sqlite3_func ); cdecl; external SQLITE_DLL name 'sqlite3_result_blob';
	{	void xDel( void* )	}
	procedure sqlite3_result_double( pCtx: sqlite3_context; rVal: Double ); cdecl; external SQLITE_DLL name 'sqlite3_result_double';
	procedure sqlite3_result_error( pCtx: sqlite3_context; z: PChar; n: Integer ); cdecl; external SQLITE_DLL name 'sqlite3_result_error';
	procedure sqlite3_result_error16( pCtx: sqlite3_context; z: PChar; n: Integer ); cdecl; external SQLITE_DLL name 'sqlite3_result_error16';
	procedure sqlite3_result_error_code( pCtx: sqlite3_context; errCode: Integer ); cdecl; external SQLITE_DLL name 'sqlite3_result_error_code';
	procedure sqlite3_result_error_nomem( pCtx: sqlite3_context ); cdecl; external SQLITE_DLL name 'sqlite3_result_error_nomem';
	procedure sqlite3_result_error_toobig( pCtx: sqlite3_context ); cdecl; external SQLITE_DLL name 'sqlite3_result_error_toobig';
	procedure sqlite3_result_int( pCtx: sqlite3_context; iVal: Integer ); cdecl; external SQLITE_DLL name 'sqlite3_result_int';
	procedure sqlite3_result_int64( pCtx: sqlite3_context; iVal: sqlite3_int64 ); cdecl; external SQLITE_DLL name 'sqlite3_result_int64';
	procedure sqlite3_result_null( pCtx: sqlite3_context ); cdecl; external SQLITE_DLL name 'sqlite3_result_null';
	procedure sqlite3_result_text( pCtx: sqlite3_context; z: PChar; n: Integer; xDel: sqlite3_func ); cdecl; external SQLITE_DLL name 'sqlite3_result_text';
	procedure sqlite3_result_text16( pCtx: sqlite3_context; z: PChar; n: Integer; xDel: sqlite3_func ); cdecl; external SQLITE_DLL name 'sqlite3_result_text16';
	procedure sqlite3_result_text16be( pCtx: sqlite3_context; z: PChar; n: Integer; xDel: sqlite3_func ); cdecl; external SQLITE_DLL name 'sqlite3_result_text16be';
	procedure sqlite3_result_text16le( pCtx: sqlite3_context; z: PChar; n: Integer; xDel: sqlite3_func ); cdecl; external SQLITE_DLL name 'sqlite3_result_text16le';
	{	void xDel( void* )	}
	procedure sqlite3_result_value( pCtx: sqlite3_context; pValue: sqlite3_value ); cdecl; external SQLITE_DLL name 'sqlite3_result_value';
	procedure sqlite3_result_zeroblob( pCtx: sqlite3_context; n: Integer ); cdecl; external SQLITE_DLL name 'sqlite3_result_zeroblob';
	function  sqlite3_rollback_hook( db: sqlite3; xCallback: sqlite3_func; pArg: Pointer ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_rollback_hook';
	{	void xCallback( void* )	}
	function  sqlite3_rtree_geometry_callback( db: sqlite3; zGeom: PChar; xGeom: sqlite3_func; pContext: Pointer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_rtree_geometry_callback';
	{	int xGeom( sqlite3_rtree_geometry *, int nCoord, double *aCoord, int *pRes )	}
	function  sqlite3_set_authorizer( db: sqlite3; xAuth: sqlite3_func; pArg: Pointer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_set_authorizer';
	{	int xAuth( void*, int, char*, char*, char*, char* )	}
	procedure sqlite3_set_auxdata( pCtx: sqlite3_context; iArg: Integer; pAux: Pointer; xDelete: sqlite3_func ); cdecl; external SQLITE_DLL name 'sqlite3_set_auxdata';
	{	void xDelete( void* )	}
	function  sqlite3_shutdown(): Integer; cdecl; external SQLITE_DLL name 'sqlite3_shutdown';
	function  sqlite3_sleep( ms: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_sleep';
	function  sqlite3_snprintf( n: Integer; zBuf: PChar; zFormat: PChar; x: array of const ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_snprintf';
	procedure sqlite3_soft_heap_limit( n: Integer ); cdecl; external SQLITE_DLL name 'sqlite3_soft_heap_limit';
	function  sqlite3_soft_heap_limit64( n: sqlite3_int64 ): sqlite3_int64; cdecl; external SQLITE_DLL name 'sqlite3_soft_heap_limit64';
	function  sqlite3_sourceid(): PChar; cdecl; external SQLITE_DLL name 'sqlite3_sourceid';
	function  sqlite3_sql( pStmt: sqlite3_stmt ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_sql';
	function  sqlite3_status( op: Integer; var pCurrent: Integer; var pHighwater: Integer; resetFlag: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_status';
	function  sqlite3_step( pStmt: sqlite3_stmt ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_step';
	function  sqlite3_stmt_status( pStmt: sqlite3_stmt; op: Integer; resetFlg: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_stmt_status';
	function  sqlite3_strnicmp( zLeft: PChar; zRight: PChar; N: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_strnicmp';
	function  sqlite3_table_column_metadata( db: sqlite3; zDbName: PChar; zTableName: PChar; zColumnName: PChar; var pzDataType: PChar; var pzCollSeq: PChar; var pNotNull: Integer; var pPrimaryKey: Integer; var pAutoinc: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_table_column_metadata';
	function  sqlite3_test_control( op: Integer; x: array of const ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_test_control';
	procedure sqlite3_thread_cleanup(); cdecl; external SQLITE_DLL name 'sqlite3_thread_cleanup';
	function  sqlite3_threadsafe(): Integer; cdecl; external SQLITE_DLL name 'sqlite3_threadsafe';
	function  sqlite3_total_changes( db: sqlite3 ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_total_changes';
	function  sqlite3_trace( db: sqlite3; xTrace: sqlite3_func; pArg: Pointer ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_trace';
	{	void xTrace( void*, char* )	}
	function  sqlite3_transfer_bindings( pFromStmt: sqlite3_stmt; pToStmt: sqlite3_stmt ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_transfer_bindings';
	function  sqlite3_update_hook( db: sqlite3; xCallback: sqlite3_func; pArg: Pointer ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_update_hook';
	{	void xCallback( void*, int, char*, char*, sqlite_int64 )	}
	function  sqlite3_user_data( p: sqlite3_context ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_user_data';
	function  sqlite3_value_blob( pVal: sqlite3_value ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_value_blob';
	function  sqlite3_value_bytes( pVal: sqlite3_value ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_value_bytes';
	function  sqlite3_value_bytes16( pVal: sqlite3_value ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_value_bytes16';
	function  sqlite3_value_double( pVal: sqlite3_value ): Double; cdecl; external SQLITE_DLL name 'sqlite3_value_double';
	function  sqlite3_value_int( pVal: sqlite3_value ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_value_int';
	function  sqlite3_value_int64( pVal: sqlite3_value ): sqlite3_int64; cdecl; external SQLITE_DLL name 'sqlite3_value_int64';
	function  sqlite3_value_text( pVal: sqlite3_value ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_value_text';
	function  sqlite3_value_numeric_type( pVal: sqlite3_value ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_value_numeric_type';
	function  sqlite3_value_text16( pVal: sqlite3_value ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_value_text16';
	function  sqlite3_value_text16be( pVal: sqlite3_value ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_value_text16be';
	function  sqlite3_value_text16le( pVal: sqlite3_value ): Pointer; cdecl; external SQLITE_DLL name 'sqlite3_value_text16le';
	function  sqlite3_value_type( pVal: sqlite3_value ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_value_type';
	function  sqlite3_version(): PChar; cdecl; external SQLITE_DLL name 'sqlite3_version';
	function  sqlite3_vfs_find( zVfsName: PChar ): psqlite3_vfs; cdecl; external SQLITE_DLL name 'sqlite3_vfs_find';
	function  sqlite3_vfs_register( pVfs: psqlite3_vfs; makeDflt: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_vfs_register';
	function  sqlite3_vfs_unregister( pVfs: psqlite3_vfs ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_vfs_unregister';
	function  sqlite3_vmprintf( zFormat: PChar; ap: Pointer ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_vmprintf';
	function  sqlite3_wal_autocheckpoint( db: sqlite3; N: Integer ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_wal_autocheckpoint';
	function  sqlite3_wal_checkpoint( db: sqlite3; zDb: PChar ): Integer; cdecl; external SQLITE_DLL name 'sqlite3_wal_checkpoint';
	procedure sqlite3_wal_hook( db: sqlite3; xCallback: sqlite3_func; pArg: Pointer ); cdecl; external SQLITE_DLL name 'sqlite3_wal_hook';
	{	int xCallback( void*, sqlite3*, char*, int )		}
	function  sqlite3_win32_mbcs_to_utf8( zFilename: PChar ): PChar; cdecl; external SQLITE_DLL name 'sqlite3_win32_mbcs_to_utf8';

implementation
end.
