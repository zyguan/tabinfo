package tabinfo

import (
	"fmt"
	"strings"
)

type Column struct {
	Name, Type string
}

type TabInfo struct {
	Name string
	Cols []Column
}

type InfoBuilder struct {
	*Lexer
	Info *TabInfo
}

func Parse(schema string) (info *TabInfo, err error) {
	defer func() {
		if r := recover(); r != nil {
			var ok bool
			err, ok = r.(error)
			if !ok {
				err = fmt.Errorf("%v", r)
			}
		}
	}()
	builder := &InfoBuilder{Lexer: NewLexer(strings.NewReader(schema))}
	yyParse(builder)
	return builder.Info, nil
}
