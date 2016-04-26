%{

package tabinfo

import ("fmt")

%}

%union{
	text string
	col  Column
	cols []Column
}

%token <text>
	CREATE
	TABLE
	NAME
	IF
	NOT
	EXISTS
	NUM_LIT
	STR_LIT
	BLOB_LIT
	CONSTRAINT
	ASC
	DESC
	PRIMARY
	KEY
	AUTOINCREMENT
	NULL
	UNIQUE
	DEFAULT
	COLLATE
	FOREIGN
	ON
	CONFLICT
	ROLLBACK
	ABORT
	IGNORE
	REPLACE
	REFERENCES
	FAIL

%type <text>
	signed_number
	literal_value
	opt_type_name

%type <col>
	column_def

%type <cols>
	column_defs
	column_info

%%

tab_schema
:	CREATE TABLE opt_if_not_exists NAME '(' column_info ')'
		{ yylex.(*InfoBuilder).Info = &TabInfo{$4, $6}; }
|	CREATE TABLE opt_if_not_exists NAME '.' NAME '(' column_info ')'
		{ yylex.(*InfoBuilder).Info = &TabInfo{$4+"."+$6, $8}; }
;

opt_if_not_exists:
|	IF NOT EXISTS
;

column_info
:	column_defs
|	column_defs ',' table_constraints
;

column_defs
:	column_def
		{ $$ = []Column{$1}; }
|	column_defs ',' column_def
		{ $$ = append($1, $3); }
;

table_constraints
:	table_constraint
|	table_constraints ',' table_constraint
;

column_def
:	NAME opt_type_name opt_column_constraints
		{ $$ = Column{$1, $2}; }
;

opt_type_name: { $$ = ""; }
|	NAME
|	NAME '(' signed_number ')' 
		{ $$ = fmt.Sprintf("%s(%s)", $1, $3); }
|	NAME '(' signed_number ',' signed_number ')'
		{ $$ = fmt.Sprintf("%s(%s,%s)", $1, $3, $5); }
;

opt_column_constraints:
|	opt_column_constraints opt_constraint_name column_constraint
;

column_constraint
:	PRIMARY KEY opt_sort_order opt_conflict_clause
|	PRIMARY KEY opt_sort_order opt_conflict_clause AUTOINCREMENT
|	NOT NULL opt_conflict_clause
|	UNIQUE opt_conflict_clause
|	DEFAULT literal_value
|	COLLATE NAME
|	foreign_key_clause
;

table_constraint
:	opt_constraint_name FOREIGN KEY '(' column_names ')' foreign_key_clause
|	opt_constraint_name PRIMARY KEY '(' column_names ')' opt_conflict_clause
|	opt_constraint_name UNIQUE '(' column_names ')' opt_conflict_clause
;

opt_constraint_name:
|	CONSTRAINT NAME
;

opt_sort_order:
|	ASC
|	DESC
;

foreign_key_clause
:	REFERENCES NAME
|	REFERENCES NAME '(' column_names ')'
;

opt_conflict_clause:
|	ON CONFLICT ROLLBACK
|	ON CONFLICT ABORT
|	ON CONFLICT FAIL
|	ON CONFLICT IGNORE
|	ON CONFLICT REPLACE
;

column_names
:	NAME
|	column_names ',' NAME
;

literal_value
:	NUM_LIT
|	STR_LIT
|	BLOB_LIT
|	NULL
;

signed_number
:	NUM_LIT
|	'+' NUM_LIT { $$ = "+"+$2; }
|	'-' NUM_LIT { $$ = "-"+$2; }
;
