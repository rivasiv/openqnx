
BEGIN		{
		    print "/****************************************************************************"
		    print " * Copyright (c) 1998 Free Software Foundation, Inc.                        *"
		    print " *                                                                          *"
		    print " * Permission is hereby granted, free of charge, to any person obtaining a  *"
		    print " * copy of this software and associated documentation files (the            *"
		    print " * "Software"), to deal in the Software without restriction, including      *"
		    print " * without limitation the rights to use, copy, modify, merge, publish,      *"
		    print " * distribute, distribute with modifications, sublicense, and/or sell       *"
		    print " * copies of the Software, and to permit persons to whom the Software is    *"
		    print " * furnished to do so, subject to the following conditions:                 *"
		    print " *                                                                          *"
		    print " * The above copyright notice and this permission notice shall be included  *"
		    print " * in all copies or substantial portions of the Software.                   *"
		    print " *                                                                          *"
		    print " * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS  *"
		    print " * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF               *"
		    print " * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.   *"
		    print " * IN NO EVENT SHALL THE ABOVE COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,   *"
		    print " * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR    *"
		    print " * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR    *"
		    print " * THE USE OR OTHER DEALINGS IN THE SOFTWARE.                               *"
		    print " *                                                                          *"
		    print " * Except as contained in this notice, the name(s) of the above copyright   *"
		    print " * holders shall not be used in advertising or otherwise to promote the     *"
		    print " * sale, use or other dealings in this Software without prior written       *"
		    print " * authorization.                                                           *"
		    print " ****************************************************************************/"
		    print ""
		    print "/****************************************************************************/"
		    print "/* Author: Zeyd M. Ben-Halim <zmbenhal@netcom.com> 1992,1995                */"
		    print "/*    and: Eric S. Raymond <esr@snark.thyrsus.com>                          */"
		    print "/****************************************************************************/"
		    print ""
		    print "/* $Id: MKterm.h.awk 153052 2008-08-13 01:17:50Z coreos $ */"
		    print ""
		    print "/*"
		    print "**	term.h -- Definition of struct term"
		    print "*/"
		    print ""
		    print "#ifndef _TERM_H"
		    print "#define _TERM_H"
		    print ""
		    print "#undef  NCURSES_VERSION"
		    print "#define NCURSES_VERSION \"4.2\""
		    print ""
		    print "#ifdef __cplusplus"
		    print "extern \"C\" {"
		    print "#endif"
		    print ""
		    print "/* Make this file self-contained by providing defaults for the HAVE_TERMIO[S]_H"
		    print " * and BROKEN_LINKER definition (based on the system for which this was configured)."
		    print " */"
		    print ""
		    print "#ifndef HAVE_TERMIOS_H"
		    print "#define HAVE_TERMIOS_H 1/*default*/"
		    print "#endif"
		    print ""
		    print "#ifndef HAVE_TERMIO_H"
		    print "#define HAVE_TERMIO_H 0/*default*/"
		    print "#endif"
		    print ""
		    print "#ifndef HAVE_TCGETATTR"
		    print "#define HAVE_TCGETATTR 1/*default*/"
		    print "#endif"
		    print ""
		    print "#ifndef BROKEN_LINKER"
		    print "#define BROKEN_LINKER 0/*default*/"
		    print "#endif"
		    print ""
		    print "#ifndef NCURSES_CONST"
		    print "#define NCURSES_CONST /* nothing */"
		    print "#endif"
		    print ""
		    print "/* Assume Posix termio if we have the header and function */"
		    print "#if HAVE_TERMIOS_H && HAVE_TCGETATTR"
		    print "#ifndef TERMIOS"
		    print "#define TERMIOS 1"
		    print "#endif"
		    print "#include <termios.h>"
		    print "#define TTY struct termios"
		    print ""
		    print "#else /* !HAVE_TERMIOS_H */"
		    print ""
		    print "#if HAVE_TERMIO_H"
		    print "#ifndef TERMIOS"
		    print "#define TERMIOS 1"
		    print "#endif"
		    print "#include <termio.h>"
		    print "#define TTY struct termio"
		    print "#define TCSANOW TCSETA"
		    print "#define TCSADRAIN TCSETAW"
		    print "#define TCSAFLUSH TCSETAF"
		    print "#define tcsetattr(fd, cmd, arg) ioctl(fd, cmd, arg)"
		    print "#define tcgetattr(fd, arg) ioctl(fd, TCGETA, arg)"
		    print "#define cfgetospeed(t) ((t)->c_cflag & CBAUD)"
		    print "#define TCIFLUSH 0"
		    print "#define TCOFLUSH 1"
		    print "#define TCIOFLUSH 2"
		    print "#define tcflush(fd, arg) ioctl(fd, TCFLSH, arg)"
		    print ""
		    print "#else /* !HAVE_TERMIO_H */"
		    print ""
		    print "#undef TERMIOS"
		    print "#include <sgtty.h>"
		    print "#include <sys/ioctl.h>"
		    print "#define TTY struct sgttyb"
		    print ""
		    print "#endif /* HAVE_TERMIO_H */"
		    print ""
		    print "#endif /* HAVE_TERMIOS_H */"
		    print ""
		    print "#ifdef TERMIOS"
		    print "#define GET_TTY(fd, buf) tcgetattr(fd, buf)"
		    print "#define SET_TTY(fd, buf) tcsetattr(fd, TCSADRAIN, buf)"
		    print "#else"
		    print "#define GET_TTY(fd, buf) gtty(fd, buf)"
		    print "#define SET_TTY(fd, buf) stty(fd, buf)"
		    print "#endif"
		    print ""
		    print "extern char ttytype[];"
		    print "#define NAMESIZE 256"
		    print ""
		    print "#define CUR cur_term->type."
		    print ""
		}

$2 == "%%-STOP-HERE-%%"	{
			print  ""
			printf "#define BOOLWRITE %d\n", BoolCount
			printf "#define NUMWRITE  %d\n", NumberCount
			printf "#define STRWRITE  %d\n", StringCount
			print  ""
			print  "/* older synonyms for some capabilities */"
			print  "#define beehive_glitch	no_esc_ctlc"
			print  "#define teleray_glitch	dest_tabs_magic_smso"
			print  ""
			print  "/* XSI synonyms */"
			print  "#define micro_col_size	micro_char_size"
			print  ""
			print  "#ifdef __INTERNAL_CAPS_VISIBLE"
		}

/^#/		{next;}

$3 == "bool"	{
		    printf "#define %-30s CUR Booleans[%d]\n", $1, BoolCount++
		}

$3 == "num"	{
		    printf "#define %-30s CUR Numbers[%d]\n", $1, NumberCount++
		}

$3 == "str"	{
		    printf "#define %-30s CUR Strings[%d]\n", $1, StringCount++
		}

END		{
			print  "#endif /* __INTERNAL_CAPS_VISIBLE */"
			print  ""
			print  ""
			printf "#define BOOLCOUNT %d\n", BoolCount
			printf "#define NUMCOUNT  %d\n", NumberCount
			printf "#define STRCOUNT  %d\n", StringCount
			print  ""
			print "typedef struct termtype {	/* in-core form of terminfo data */"
			print "    char  *term_names;		/* str_table offset of term names */"
			print "    char  *str_table;		/* pointer to string table */"
			print "    char  Booleans[BOOLCOUNT];	/* array of values */"
			print "    short Numbers[NUMCOUNT];	/* array of values */"
			print "    char  *Strings[STRCOUNT];	/* array of string offsets */"
			print "} TERMTYPE;"
			print ""
			print "typedef struct term {		/* describe an actual terminal */"
			print "    TERMTYPE	type;		/* terminal type description */"
			print "    short 	Filedes;	/* file description being written to */"
			print "    TTY          Ottyb,		/* original state of the terminal */"
			print "                 Nttyb;		/* current state of the terminal */"
			print "    int          _baudrate;      /* used to compute padding */"
			print "} TERMINAL;"
			print ""
			print "extern TERMINAL	*cur_term;"
			print ""
			print ""
			print "#if BROKEN_LINKER"
			print "#define boolnames  _nc_boolnames()"
			print "#define boolcodes  _nc_boolcodes()"
			print "#define boolfnames _nc_boolfnames()"
			print "#define numnames   _nc_numnames()"
			print "#define numcodes   _nc_numcodes()"
			print "#define numfnames  _nc_numfnames()"
			print "#define strnames   _nc_strnames()"
			print "#define strcodes   _nc_strcodes()"
			print "#define strfnames  _nc_strfnames()"
			print ""
			print "extern NCURSES_CONST char * const *_nc_boolnames(void);"
			print "extern NCURSES_CONST char * const *_nc_boolcodes(void);"
			print "extern NCURSES_CONST char * const *_nc_boolfnames(void);"
			print "extern NCURSES_CONST char * const *_nc_numnames(void);"
			print "extern NCURSES_CONST char * const *_nc_numcodes(void);"
			print "extern NCURSES_CONST char * const *_nc_numfnames(void);"
			print "extern NCURSES_CONST char * const *_nc_strnames(void);"
			print "extern NCURSES_CONST char * const *_nc_strcodes(void);"
			print "extern NCURSES_CONST char * const *_nc_strfnames(void);"
			print ""
			print "#else"
			print ""
			print "extern NCURSES_CONST char *const boolnames[];"
			print "extern NCURSES_CONST char *const boolcodes[];"
			print "extern NCURSES_CONST char *const boolfnames[];"
			print "extern NCURSES_CONST char *const numnames[];"
			print "extern NCURSES_CONST char *const numcodes[];"
			print "extern NCURSES_CONST char *const numfnames[];"
			print "extern NCURSES_CONST char *const strnames[];"
			print "extern NCURSES_CONST char *const strcodes[];"
			print "extern NCURSES_CONST char *const strfnames[];"
			print ""
			print "#endif"
			print ""
			print "/* internals */"
			print "extern int _nc_set_curterm(TTY *buf);"
			print "extern int _nc_get_curterm(TTY *buf);"
			print "extern int _nc_read_entry(const char * const, char * const, TERMTYPE *const);"
			print "extern int _nc_read_file_entry(const char *const, TERMTYPE *);"
			print "extern char *_nc_first_name(const char *const);"
			print "extern int _nc_name_match(const char *const, const char *const, const char *const);"
			print "extern int _nc_read_termcap_entry(const char *const, TERMTYPE *const);"
			print "extern const TERMTYPE *_nc_fallback(const char *);"
			print  ""
			print "/* entry points */"
			print "extern TERMINAL *set_curterm(TERMINAL *);"
			print "extern int del_curterm(TERMINAL *);"
			print  ""
			print "/* miscellaneous entry points */"
			print "extern int putp(const char *);"
			print "extern int restartterm(const char *, int, int *);"
			print "extern int setupterm(const char *,int,int *);"
			print "extern int tputs(const char *, int, int (*)(int));"
			print  ""
			print "/* terminfo entry points */"
			print "extern int tigetflag(NCURSES_CONST char *);"
			print "extern int tigetnum(NCURSES_CONST char *);"
			print "extern char *tigetstr(NCURSES_CONST char *);"
			print "extern char *tparm(NCURSES_CONST char *, ...);"
			print ""
			print "/* termcap database emulation (XPG4 uses const only for 2nd param of tgetent) */"
			print "extern int tgetent(char *, const char *);"
			print "extern int tgetflag(const char *);"
			print "extern int tgetnum(const char *);"
			print "extern char *tgetstr(const char *, char **);"
			print "extern char *tgoto(const char *, int, int);"
			print ""
			print "#ifdef __cplusplus"
			print "}"
			print "#endif"
			print ""
			print "#endif /* TERM_H */"
		}
