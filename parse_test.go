package tabinfo

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

const _SCHEMA0 = `
create table if not exists
foo.bar (a int, b char(2,6) not null, primary key (a))
`

const _SCHEMA1 = `
CREATE TABLE topics (
  title TEXT,
  path  TEXT UNIQUE ON CONFLICT REPLACE,
  date  DATE,
  size  INTEGER,
  sort_id INTEGER REFERENCES sorts(id)
)`

const _SCHEMA2 = `
CREATE TABLE sorts (
  id INTEGER PRIMARY KEY ON CONFLICT REPLACE,
  name TEXT
)`

func TestParse(t *testing.T) {
	_, err := Parse(_SCHEMA2[10:])
	assert.NotNil(t, err)
	_, err = Parse(_SCHEMA0)
	assert.Nil(t, err)
	_, err = Parse(_SCHEMA1)
	assert.Nil(t, err)
	_, err = Parse(_SCHEMA2)
	assert.Nil(t, err)
}
