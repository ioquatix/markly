#ifndef MARKLY_H
#define MARKLY_H

#ifndef __MSXML_LIBRARY_DEFINED__
#define __MSXML_LIBRARY_DEFINED__
#endif

#include "cmark-gfm.h"
#include "ruby.h"
#include "ruby/encoding.h"

#define CSTR2SYM(s) (ID2SYM(rb_intern((s))))

void Init_markly(void);

#endif
