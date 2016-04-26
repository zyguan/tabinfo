/[Aa][Bb][Oo][Rr][Tt]/					{ lval.text = "ABORT"; return ABORT; }
/[Aa][Ss][Cc]/						{ lval.text = "ASC"; return ASC; }
/[Aa][Uu][Tt][Oo][Ii][Nn][Cc][Rr][Ee][Mm][Ee][Nn][Tt]/	{ lval.text = "AUTOINCREMENT"; return AUTOINCREMENT; }
/[Cc][Oo][Ll][Ll][Aa][Tt][Ee]/				{ lval.text = "COLLATE"; return COLLATE; }
/[Cc][Oo][Nn][Ff][Ll][Ii][Cc][Tt]/			{ lval.text = "CONFLICT"; return CONFLICT; }
/[Cc][Oo][Nn][Ss][Tt][Rr][Aa][Ii][Nn][Tt]/		{ lval.text = "CONSTRAINT"; return CONSTRAINT; }
/[Cc][Rr][Ee][Aa][Tt][Ee]/				{ lval.text = "CREATE"; return CREATE; }
/[Dd][Ee][Ff][Aa][Uu][Ll][Tt]/				{ lval.text = "DEFAULT"; return DEFAULT; }
/[Dd][Ee][Ss][Cc]/					{ lval.text = "DESC"; return DESC; }
/[Ee][Xx][Ii][Ss][Tt][Ss]/				{ lval.text = "EXISTS"; return EXISTS; }
/[Ff][Aa][Ii][Ll]/					{ lval.text = "FAIL"; return FAIL; }
/[Ff][Oo][Rr][Ee][Ii][Gg][Nn]/				{ lval.text = "FOREIGN"; return FOREIGN; }
/[Ii][Ff]/						{ lval.text = "IF"; return IF; }
/[Ii][Gg][Nn][Oo][Rr][Ee]/				{ lval.text = "IGNORE"; return IGNORE; }
/[Kk][Ee][Yy]/						{ lval.text = "KEY"; return KEY; }
/[Nn][Oo][Tt]/						{ lval.text = "NOT"; return NOT; }
/[Nn][Uu][Ll][Ll]/					{ lval.text = "NULL"; return NULL; }
/[Oo][Nn]/						{ lval.text = "ON"; return ON; }
/[Pp][Rr][Ii][Mm][Aa][Rr][Yy]/				{ lval.text = "PRIMARY"; return PRIMARY; }
/[Rr][Ee][Ff][Ee][Rr][Ee][Nn][Cc][Ee][Ss]/		{ lval.text = "REFERENCES"; return REFERENCES; }
/[Rr][Ee][Pp][Ll][Aa][Cc][Ee]/				{ lval.text = "REPLACE"; return REPLACE; }
/[Rr][Oo][Ll][Ll][Bb][Aa][Cc][Kk]/			{ lval.text = "ROLLBACK"; return ROLLBACK; }
/[Tt][Aa][Bb][Ll][Ee]/					{ lval.text = "TABLE"; return TABLE; }
/[Uu][Nn][Ii][Qq][Uu][Ee]/				{ lval.text = "UNIQUE"; return UNIQUE; }

/[A-Za-z_][A-Za-z_0-9]*/	{ lval.text = yylex.Text(); return NAME; }
/[-+(),.;]/			{ lval.text = yylex.Text(); return int(yylex.Text()[0]); }

/[0-9]+(\.[0-9]*)?([Ee][-+]?[0-9]+)?/	{ lval.text = yylex.Text(); return NUM_LIT; }
/\.[0-9]+([Ee][-+]?[0-9]+)?/		{ lval.text = yylex.Text(); return NUM_LIT; }
/'(\\.|''|[^'])*'/	{ lval.text = yylex.Text(); return STR_LIT; }
/\"(\\.|\"\"|[^"])*\"/	{ lval.text = yylex.Text(); return STR_LIT; }
/[Xx]'[0-9A-Fa-f]+'/	{ lval.text = yylex.Text(); return BLOB_LIT; }

/[ \t\n\r]/	{}
/./		{}
//

package tabinfo
