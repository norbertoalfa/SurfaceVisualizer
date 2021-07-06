// A Bison parser, made by GNU Bison 3.5.

// Skeleton implementation for Bison LALR(1) parsers in C++

// Copyright (C) 2002-2015, 2018-2019 Free Software Foundation, Inc.

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

// As a special exception, you may create a larger work that contains
// part or all of the Bison parser skeleton and distribute that work
// under terms of your choice, so long as that work isn't itself a
// parser generator using the skeleton or a modified version thereof
// as a parser skeleton.  Alternatively, if you modify or redistribute
// the parser skeleton itself, you may (at your option) remove this
// special exception, which will cause the skeleton and the resulting
// Bison output files to be licensed under the GNU General Public
// License without this special exception.

// This special exception was added by the Free Software Foundation in
// version 2.2 of Bison.

// Undocumented macros, especially those whose name start with YY_,
// are private implementation details.  Do not rely on them.



// First part of user prologue.
#line 4 "semantico.y"

	#include <stdlib.h>
	#include <stdio.h>
	#include <string.h>
	#include "semantico.h"
	#define YYDEBUG 0

	int yylex();  // Para evitar warning al compilar
	void yyerror(const char * msg);


#line 52 "y.tab.c"


#include "y.tab.h"




#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> // FIXME: INFRINGES ON USER NAME SPACE.
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

// Whether we are compiled with exception support.
#ifndef YY_EXCEPTIONS
# if defined __GNUC__ && !defined __EXCEPTIONS
#  define YY_EXCEPTIONS 0
# else
#  define YY_EXCEPTIONS 1
# endif
#endif



// Enable debugging if requested.
#if YYDEBUG

// A pseudo ostream that takes yydebug_ into account.
# define YYCDEBUG if (yydebug_) (*yycdebug_)

# define YY_SYMBOL_PRINT(Title, Symbol)         \
  do {                                          \
    if (yydebug_)                               \
    {                                           \
      *yycdebug_ << Title << ' ';               \
      yy_print_ (*yycdebug_, Symbol);           \
      *yycdebug_ << '\n';                       \
    }                                           \
  } while (false)

# define YY_REDUCE_PRINT(Rule)          \
  do {                                  \
    if (yydebug_)                       \
      yy_reduce_print_ (Rule);          \
  } while (false)

# define YY_STACK_PRINT()               \
  do {                                  \
    if (yydebug_)                       \
      yystack_print_ ();                \
  } while (false)

#else // !YYDEBUG

# define YYCDEBUG if (false) std::cerr
# define YY_SYMBOL_PRINT(Title, Symbol)  YYUSE (Symbol)
# define YY_REDUCE_PRINT(Rule)           static_cast<void> (0)
# define YY_STACK_PRINT()                static_cast<void> (0)

#endif // !YYDEBUG

#define yyerrok         (yyerrstatus_ = 0)
#define yyclearin       (yyla.clear ())

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYRECOVERING()  (!!yyerrstatus_)

namespace yy {
#line 129 "y.tab.c"


  /* Return YYSTR after stripping away unnecessary quotes and
     backslashes, so that it's suitable for yyerror.  The heuristic is
     that double-quoting is unnecessary unless the string contains an
     apostrophe, a comma, or backslash (other than backslash-backslash).
     YYSTR is taken from yytname.  */
  std::string
  parser::yytnamerr_ (const char *yystr)
  {
    if (*yystr == '"')
      {
        std::string yyr;
        char const *yyp = yystr;

        for (;;)
          switch (*++yyp)
            {
            case '\'':
            case ',':
              goto do_not_strip_quotes;

            case '\\':
              if (*++yyp != '\\')
                goto do_not_strip_quotes;
              else
                goto append;

            append:
            default:
              yyr += *yyp;
              break;

            case '"':
              return yyr;
            }
      do_not_strip_quotes: ;
      }

    return yystr;
  }


  /// Build a parser object.
  parser::parser ()
#if YYDEBUG
    : yydebug_ (false),
      yycdebug_ (&std::cerr)
#else

#endif
  {}

  parser::~parser ()
  {}

  parser::syntax_error::~syntax_error () YY_NOEXCEPT YY_NOTHROW
  {}

  /*---------------.
  | Symbol types.  |
  `---------------*/

  // basic_symbol.
#if 201103L <= YY_CPLUSPLUS
  template <typename Base>
  parser::basic_symbol<Base>::basic_symbol (basic_symbol&& that)
    : Base (std::move (that))
    , value (std::move (that.value))
  {}
#endif

  template <typename Base>
  parser::basic_symbol<Base>::basic_symbol (const basic_symbol& that)
    : Base (that)
    , value (that.value)
  {}


  /// Constructor for valueless symbols.
  template <typename Base>
  parser::basic_symbol<Base>::basic_symbol (typename Base::kind_type t)
    : Base (t)
    , value ()
  {}

  template <typename Base>
  parser::basic_symbol<Base>::basic_symbol (typename Base::kind_type t, YY_RVREF (semantic_type) v)
    : Base (t)
    , value (YY_MOVE (v))
  {}

  template <typename Base>
  bool
  parser::basic_symbol<Base>::empty () const YY_NOEXCEPT
  {
    return Base::type_get () == empty_symbol;
  }

  template <typename Base>
  void
  parser::basic_symbol<Base>::move (basic_symbol& s)
  {
    super_type::move (s);
    value = YY_MOVE (s.value);
  }

  // by_type.
  parser::by_type::by_type ()
    : type (empty_symbol)
  {}

#if 201103L <= YY_CPLUSPLUS
  parser::by_type::by_type (by_type&& that)
    : type (that.type)
  {
    that.clear ();
  }
#endif

  parser::by_type::by_type (const by_type& that)
    : type (that.type)
  {}

  parser::by_type::by_type (token_type t)
    : type (yytranslate_ (t))
  {}

  void
  parser::by_type::clear ()
  {
    type = empty_symbol;
  }

  void
  parser::by_type::move (by_type& that)
  {
    type = that.type;
    that.clear ();
  }

  int
  parser::by_type::type_get () const YY_NOEXCEPT
  {
    return type;
  }


  // by_state.
  parser::by_state::by_state () YY_NOEXCEPT
    : state (empty_state)
  {}

  parser::by_state::by_state (const by_state& that) YY_NOEXCEPT
    : state (that.state)
  {}

  void
  parser::by_state::clear () YY_NOEXCEPT
  {
    state = empty_state;
  }

  void
  parser::by_state::move (by_state& that)
  {
    state = that.state;
    that.clear ();
  }

  parser::by_state::by_state (state_type s) YY_NOEXCEPT
    : state (s)
  {}

  parser::symbol_number_type
  parser::by_state::type_get () const YY_NOEXCEPT
  {
    if (state == empty_state)
      return empty_symbol;
    else
      return yystos_[state];
  }

  parser::stack_symbol_type::stack_symbol_type ()
  {}

  parser::stack_symbol_type::stack_symbol_type (YY_RVREF (stack_symbol_type) that)
    : super_type (YY_MOVE (that.state), YY_MOVE (that.value))
  {
#if 201103L <= YY_CPLUSPLUS
    // that is emptied.
    that.state = empty_state;
#endif
  }

  parser::stack_symbol_type::stack_symbol_type (state_type s, YY_MOVE_REF (symbol_type) that)
    : super_type (s, YY_MOVE (that.value))
  {
    // that is emptied.
    that.type = empty_symbol;
  }

#if YY_CPLUSPLUS < 201103L
  parser::stack_symbol_type&
  parser::stack_symbol_type::operator= (const stack_symbol_type& that)
  {
    state = that.state;
    value = that.value;
    return *this;
  }

  parser::stack_symbol_type&
  parser::stack_symbol_type::operator= (stack_symbol_type& that)
  {
    state = that.state;
    value = that.value;
    // that is emptied.
    that.state = empty_state;
    return *this;
  }
#endif

  template <typename Base>
  void
  parser::yy_destroy_ (const char* yymsg, basic_symbol<Base>& yysym) const
  {
    if (yymsg)
      YY_SYMBOL_PRINT (yymsg, yysym);

    // User destructor.
    YYUSE (yysym.type_get ());
  }

#if YYDEBUG
  template <typename Base>
  void
  parser::yy_print_ (std::ostream& yyo,
                                     const basic_symbol<Base>& yysym) const
  {
    std::ostream& yyoutput = yyo;
    YYUSE (yyoutput);
    symbol_number_type yytype = yysym.type_get ();
#if defined __GNUC__ && ! defined __clang__ && ! defined __ICC && __GNUC__ * 100 + __GNUC_MINOR__ <= 408
    // Avoid a (spurious) G++ 4.8 warning about "array subscript is
    // below array bounds".
    if (yysym.empty ())
      std::abort ();
#endif
    yyo << (yytype < yyntokens_ ? "token" : "nterm")
        << ' ' << yytname_[yytype] << " (";
    YYUSE (yytype);
    yyo << ')';
  }
#endif

  void
  parser::yypush_ (const char* m, YY_MOVE_REF (stack_symbol_type) sym)
  {
    if (m)
      YY_SYMBOL_PRINT (m, sym);
    yystack_.push (YY_MOVE (sym));
  }

  void
  parser::yypush_ (const char* m, state_type s, YY_MOVE_REF (symbol_type) sym)
  {
#if 201103L <= YY_CPLUSPLUS
    yypush_ (m, stack_symbol_type (s, std::move (sym)));
#else
    stack_symbol_type ss (s, sym);
    yypush_ (m, ss);
#endif
  }

  void
  parser::yypop_ (int n)
  {
    yystack_.pop (n);
  }

#if YYDEBUG
  std::ostream&
  parser::debug_stream () const
  {
    return *yycdebug_;
  }

  void
  parser::set_debug_stream (std::ostream& o)
  {
    yycdebug_ = &o;
  }


  parser::debug_level_type
  parser::debug_level () const
  {
    return yydebug_;
  }

  void
  parser::set_debug_level (debug_level_type l)
  {
    yydebug_ = l;
  }
#endif // YYDEBUG

  parser::state_type
  parser::yy_lr_goto_state_ (state_type yystate, int yysym)
  {
    int yyr = yypgoto_[yysym - yyntokens_] + yystate;
    if (0 <= yyr && yyr <= yylast_ && yycheck_[yyr] == yystate)
      return yytable_[yyr];
    else
      return yydefgoto_[yysym - yyntokens_];
  }

  bool
  parser::yy_pact_value_is_default_ (int yyvalue)
  {
    return yyvalue == yypact_ninf_;
  }

  bool
  parser::yy_table_value_is_error_ (int yyvalue)
  {
    return yyvalue == yytable_ninf_;
  }

  int
  parser::operator() ()
  {
    return parse ();
  }

  int
  parser::parse ()
  {
    int yyn;
    /// Length of the RHS of the rule being reduced.
    int yylen = 0;

    // Error handling.
    int yynerrs_ = 0;
    int yyerrstatus_ = 0;

    /// The lookahead symbol.
    symbol_type yyla;

    /// The return value of parse ().
    int yyresult;

#if YY_EXCEPTIONS
    try
#endif // YY_EXCEPTIONS
      {
    YYCDEBUG << "Starting parse\n";


    /* Initialize the stack.  The initial state will be set in
       yynewstate, since the latter expects the semantical and the
       location values to have been already stored, initialize these
       stacks with a primary value.  */
    yystack_.clear ();
    yypush_ (YY_NULLPTR, 0, YY_MOVE (yyla));

  /*-----------------------------------------------.
  | yynewstate -- push a new symbol on the stack.  |
  `-----------------------------------------------*/
  yynewstate:
    YYCDEBUG << "Entering state " << int (yystack_[0].state) << '\n';

    // Accept?
    if (yystack_[0].state == yyfinal_)
      YYACCEPT;

    goto yybackup;


  /*-----------.
  | yybackup.  |
  `-----------*/
  yybackup:
    // Try to take a decision without lookahead.
    yyn = yypact_[yystack_[0].state];
    if (yy_pact_value_is_default_ (yyn))
      goto yydefault;

    // Read a lookahead token.
    if (yyla.empty ())
      {
        YYCDEBUG << "Reading a token: ";
#if YY_EXCEPTIONS
        try
#endif // YY_EXCEPTIONS
          {
            yyla.type = yytranslate_ (yylex (&yyla.value));
          }
#if YY_EXCEPTIONS
        catch (const syntax_error& yyexc)
          {
            YYCDEBUG << "Caught exception: " << yyexc.what() << '\n';
            error (yyexc);
            goto yyerrlab1;
          }
#endif // YY_EXCEPTIONS
      }
    YY_SYMBOL_PRINT ("Next token is", yyla);

    /* If the proper action on seeing token YYLA.TYPE is to reduce or
       to detect an error, take that action.  */
    yyn += yyla.type_get ();
    if (yyn < 0 || yylast_ < yyn || yycheck_[yyn] != yyla.type_get ())
      {
        goto yydefault;
      }

    // Reduce or error.
    yyn = yytable_[yyn];
    if (yyn <= 0)
      {
        if (yy_table_value_is_error_ (yyn))
          goto yyerrlab;
        yyn = -yyn;
        goto yyreduce;
      }

    // Count tokens shifted since error; after three, turn off error status.
    if (yyerrstatus_)
      --yyerrstatus_;

    // Shift the lookahead token.
    yypush_ ("Shifting", static_cast<state_type> (yyn), YY_MOVE (yyla));
    goto yynewstate;


  /*-----------------------------------------------------------.
  | yydefault -- do the default action for the current state.  |
  `-----------------------------------------------------------*/
  yydefault:
    yyn = yydefact_[yystack_[0].state];
    if (yyn == 0)
      goto yyerrlab;
    goto yyreduce;


  /*-----------------------------.
  | yyreduce -- do a reduction.  |
  `-----------------------------*/
  yyreduce:
    yylen = yyr2_[yyn];
    {
      stack_symbol_type yylhs;
      yylhs.state = yy_lr_goto_state_ (yystack_[yylen].state, yyr1_[yyn]);
      /* If YYLEN is nonzero, implement the default value of the
         action: '$$ = $1'.  Otherwise, use the top of the stack.

         Otherwise, the following line sets YYLHS.VALUE to garbage.
         This behavior is undocumented and Bison users should not rely
         upon it.  */
      if (yylen)
        yylhs.value = yystack_[yylen - 1].value;
      else
        yylhs.value = yystack_[0].value;


      // Perform the reduction.
      YY_REDUCE_PRINT (yyn);
#if YY_EXCEPTIONS
      try
#endif // YY_EXCEPTIONS
        {
          switch (yyn)
            {
  case 9:
#line 60 "semantico.y"
                                                             { setTipo(yystack_[2].value); TS_InsertaIDENT(yystack_[4].value); comprobarTipoCte(yystack_[0].value); }
#line 607 "y.tab.c"
    break;

  case 10:
#line 63 "semantico.y"
                             {setTipoDesc(); TS_InsertaFUN(yystack_[0].value); }
#line 613 "y.tab.c"
    break;

  case 11:
#line 63 "semantico.y"
                                                                                                            { setTipo(yystack_[0].value); TS_ActualizarFun(); TS_InsertaMARCA(); }
#line 619 "y.tab.c"
    break;

  case 12:
#line 63 "semantico.y"
                                                                                                                                                                                    {	comprobarTipoFun(yystack_[9].value, yystack_[0].value); TS_VaciarENTRADAS(); nParam = 0; decParam=0; }
#line 625 "y.tab.c"
    break;

  case 13:
#line 66 "semantico.y"
                                                { TS_InsertaPLOT(yystack_[0].value); }
#line 631 "y.tab.c"
    break;

  case 14:
#line 67 "semantico.y"
                                                                        { setTipoDesc(); TS_InsertaFUN(yystack_[1].value); TS_InsertaPLOT(yystack_[0].value); }
#line 637 "y.tab.c"
    break;

  case 15:
#line 70 "semantico.y"
                                                                        { yylhs.value.tipo=yystack_[1].value.tipo; yylhs.value.dimension=yystack_[1].value.dimension; yylhs.value.tam=yystack_[1].value.tam; }
#line 643 "y.tab.c"
    break;

  case 16:
#line 71 "semantico.y"
                                                        { comprobarIF(yystack_[4].value, yystack_[2].value, yystack_[0].value, &yylhs.value); }
#line 649 "y.tab.c"
    break;

  case 17:
#line 72 "semantico.y"
                                                                { comprobarIND(yystack_[3].value, yystack_[1].value, &yylhs.value); }
#line 655 "y.tab.c"
    break;

  case 18:
#line 73 "semantico.y"
                                                                                        { yylhs.value.tipo=yystack_[0].value.tipo; yylhs.value.dimension=yystack_[0].value.dimension; yylhs.value.tam=yystack_[0].value.tam; }
#line 661 "y.tab.c"
    break;

  case 19:
#line 74 "semantico.y"
                                                                                { TS_OpUNARIA(yystack_[1].value, yystack_[0].value, &yylhs.value); }
#line 667 "y.tab.c"
    break;

  case 20:
#line 75 "semantico.y"
                                                                                { TS_OpUNARIA(yystack_[1].value, yystack_[0].value, &yylhs.value); }
#line 673 "y.tab.c"
    break;

  case 21:
#line 76 "semantico.y"
                                                                        { TS_OpSUMARESTA(yystack_[2].value, yystack_[1].value, yystack_[0].value, &yylhs.value); }
#line 679 "y.tab.c"
    break;

  case 22:
#line 77 "semantico.y"
                                                                        { TS_OpSUMARESTA(yystack_[2].value, yystack_[1].value, yystack_[0].value, &yylhs.value); }
#line 685 "y.tab.c"
    break;

  case 23:
#line 78 "semantico.y"
                                                                        { TS_OpMULTIP(yystack_[2].value, yystack_[1].value, yystack_[0].value, &yylhs.value); }
#line 691 "y.tab.c"
    break;

  case 24:
#line 79 "semantico.y"
                                                                        { TS_OpIGUAL(yystack_[2].value, yystack_[1].value, yystack_[0].value, &yylhs.value); }
#line 697 "y.tab.c"
    break;

  case 25:
#line 80 "semantico.y"
                                                                        { TS_OpCOMP(yystack_[2].value, yystack_[1].value, yystack_[0].value, &yylhs.value); }
#line 703 "y.tab.c"
    break;

  case 26:
#line 81 "semantico.y"
                                                                        { TS_OpOR(yystack_[2].value, yystack_[1].value, yystack_[0].value, &yylhs.value); }
#line 709 "y.tab.c"
    break;

  case 27:
#line 82 "semantico.y"
                                                                        { TS_OpAND(yystack_[2].value, yystack_[1].value, yystack_[0].value, &yylhs.value); }
#line 715 "y.tab.c"
    break;

  case 28:
#line 83 "semantico.y"
                                                                                                { declaracion=0; TS_getIDENT(yystack_[0].value, &yylhs.value); }
#line 721 "y.tab.c"
    break;

  case 29:
#line 84 "semantico.y"
                                                                                        { yylhs.value.tipo=yystack_[0].value.tipo; yylhs.value.dimension=yystack_[0].value.dimension; yylhs.value.tam=yystack_[0].value.tam; }
#line 727 "y.tab.c"
    break;

  case 31:
#line 88 "semantico.y"
                                                                { TS_FunCall(yystack_[3].value, yystack_[1].value, &yylhs.value); }
#line 733 "y.tab.c"
    break;

  case 32:
#line 91 "semantico.y"
                                                        { yylhs.value.nArg=yystack_[2].value.nArg + 1; TS_ComprobarPARAM(yystack_[(3) - (-1)].value,yystack_[0].value, yylhs.value.nArg); }
#line 739 "y.tab.c"
    break;

  case 33:
#line 92 "semantico.y"
                                                                                        { yylhs.value.nArg=1; TS_ComprobarPARAM(yystack_[(1) - (-1)].value,yystack_[0].value, yylhs.value.nArg); }
#line 745 "y.tab.c"
    break;

  case 34:
#line 95 "semantico.y"
                                                                { actualizaTipoDesc(yystack_[0].value); }
#line 751 "y.tab.c"
    break;

  case 35:
#line 96 "semantico.y"
                                                                                { actualizaTipoDesc(yystack_[0].value); }
#line 757 "y.tab.c"
    break;

  case 36:
#line 99 "semantico.y"
                                        { nParam++; parDesc++; setTipoDesc(); TS_InsertaPARAMF(yystack_[0].value); }
#line 763 "y.tab.c"
    break;

  case 37:
#line 100 "semantico.y"
                                                                { decParam=1; nParam++; parDesc++; setTipoDesc(); TS_InsertaPARAMF(yystack_[0].value); }
#line 769 "y.tab.c"
    break;

  case 38:
#line 103 "semantico.y"
                                { yylhs.value.tipo = BOOLEANO; yylhs.value.dimension = 0; yylhs.value.tam = 0; }
#line 775 "y.tab.c"
    break;

  case 39:
#line 104 "semantico.y"
                                { yylhs.value.tipo = ENTERO; yylhs.value.dimension = 0; yylhs.value.tam = 0; }
#line 781 "y.tab.c"
    break;

  case 40:
#line 105 "semantico.y"
                                { yylhs.value.tipo = REAL; yylhs.value.dimension = 0; yylhs.value.tam = 0; }
#line 787 "y.tab.c"
    break;


#line 791 "y.tab.c"

            default:
              break;
            }
        }
#if YY_EXCEPTIONS
      catch (const syntax_error& yyexc)
        {
          YYCDEBUG << "Caught exception: " << yyexc.what() << '\n';
          error (yyexc);
          YYERROR;
        }
#endif // YY_EXCEPTIONS
      YY_SYMBOL_PRINT ("-> $$ =", yylhs);
      yypop_ (yylen);
      yylen = 0;
      YY_STACK_PRINT ();

      // Shift the result of the reduction.
      yypush_ (YY_NULLPTR, YY_MOVE (yylhs));
    }
    goto yynewstate;


  /*--------------------------------------.
  | yyerrlab -- here on detecting error.  |
  `--------------------------------------*/
  yyerrlab:
    // If not already recovering from an error, report this error.
    if (!yyerrstatus_)
      {
        ++yynerrs_;
        error (yysyntax_error_ (yystack_[0].state, yyla));
      }


    if (yyerrstatus_ == 3)
      {
        /* If just tried and failed to reuse lookahead token after an
           error, discard it.  */

        // Return failure if at end of input.
        if (yyla.type_get () == yyeof_)
          YYABORT;
        else if (!yyla.empty ())
          {
            yy_destroy_ ("Error: discarding", yyla);
            yyla.clear ();
          }
      }

    // Else will try to reuse lookahead token after shifting the error token.
    goto yyerrlab1;


  /*---------------------------------------------------.
  | yyerrorlab -- error raised explicitly by YYERROR.  |
  `---------------------------------------------------*/
  yyerrorlab:
    /* Pacify compilers when the user code never invokes YYERROR and
       the label yyerrorlab therefore never appears in user code.  */
    if (false)
      YYERROR;

    /* Do not reclaim the symbols of the rule whose action triggered
       this YYERROR.  */
    yypop_ (yylen);
    yylen = 0;
    goto yyerrlab1;


  /*-------------------------------------------------------------.
  | yyerrlab1 -- common code for both syntax error and YYERROR.  |
  `-------------------------------------------------------------*/
  yyerrlab1:
    yyerrstatus_ = 3;   // Each real token shifted decrements this.
    {
      stack_symbol_type error_token;
      for (;;)
        {
          yyn = yypact_[yystack_[0].state];
          if (!yy_pact_value_is_default_ (yyn))
            {
              yyn += yy_error_token_;
              if (0 <= yyn && yyn <= yylast_ && yycheck_[yyn] == yy_error_token_)
                {
                  yyn = yytable_[yyn];
                  if (0 < yyn)
                    break;
                }
            }

          // Pop the current state because it cannot handle the error token.
          if (yystack_.size () == 1)
            YYABORT;

          yy_destroy_ ("Error: popping", yystack_[0]);
          yypop_ ();
          YY_STACK_PRINT ();
        }


      // Shift the error token.
      error_token.state = static_cast<state_type> (yyn);
      yypush_ ("Shifting", YY_MOVE (error_token));
    }
    goto yynewstate;


  /*-------------------------------------.
  | yyacceptlab -- YYACCEPT comes here.  |
  `-------------------------------------*/
  yyacceptlab:
    yyresult = 0;
    goto yyreturn;


  /*-----------------------------------.
  | yyabortlab -- YYABORT comes here.  |
  `-----------------------------------*/
  yyabortlab:
    yyresult = 1;
    goto yyreturn;


  /*-----------------------------------------------------.
  | yyreturn -- parsing is finished, return the result.  |
  `-----------------------------------------------------*/
  yyreturn:
    if (!yyla.empty ())
      yy_destroy_ ("Cleanup: discarding lookahead", yyla);

    /* Do not reclaim the symbols of the rule whose action triggered
       this YYABORT or YYACCEPT.  */
    yypop_ (yylen);
    while (1 < yystack_.size ())
      {
        yy_destroy_ ("Cleanup: popping", yystack_[0]);
        yypop_ ();
      }

    return yyresult;
  }
#if YY_EXCEPTIONS
    catch (...)
      {
        YYCDEBUG << "Exception caught: cleaning lookahead and stack\n";
        // Do not try to display the values of the reclaimed symbols,
        // as their printers might throw an exception.
        if (!yyla.empty ())
          yy_destroy_ (YY_NULLPTR, yyla);

        while (1 < yystack_.size ())
          {
            yy_destroy_ (YY_NULLPTR, yystack_[0]);
            yypop_ ();
          }
        throw;
      }
#endif // YY_EXCEPTIONS
  }

  void
  parser::error (const syntax_error& yyexc)
  {
    error (yyexc.what ());
  }

  // Generate an error message.
  std::string
  parser::yysyntax_error_ (state_type yystate, const symbol_type& yyla) const
  {
    // Number of reported tokens (one for the "unexpected", one per
    // "expected").
    std::ptrdiff_t yycount = 0;
    // Its maximum.
    enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
    // Arguments of yyformat.
    char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];

    /* There are many possibilities here to consider:
       - If this state is a consistent state with a default action, then
         the only way this function was invoked is if the default action
         is an error action.  In that case, don't check for expected
         tokens because there are none.
       - The only way there can be no lookahead present (in yyla) is
         if this state is a consistent state with a default action.
         Thus, detecting the absence of a lookahead is sufficient to
         determine that there is no unexpected or expected token to
         report.  In that case, just report a simple "syntax error".
       - Don't assume there isn't a lookahead just because this state is
         a consistent state with a default action.  There might have
         been a previous inconsistent state, consistent state with a
         non-default action, or user semantic action that manipulated
         yyla.  (However, yyla is currently not documented for users.)
       - Of course, the expected token list depends on states to have
         correct lookahead information, and it depends on the parser not
         to perform extra reductions after fetching a lookahead from the
         scanner and before detecting a syntax error.  Thus, state merging
         (from LALR or IELR) and default reductions corrupt the expected
         token list.  However, the list is correct for canonical LR with
         one exception: it will still contain any token that will not be
         accepted due to an error action in a later state.
    */
    if (!yyla.empty ())
      {
        symbol_number_type yytoken = yyla.type_get ();
        yyarg[yycount++] = yytname_[yytoken];

        int yyn = yypact_[yystate];
        if (!yy_pact_value_is_default_ (yyn))
          {
            /* Start YYX at -YYN if negative to avoid negative indexes in
               YYCHECK.  In other words, skip the first -YYN actions for
               this state because they are default actions.  */
            int yyxbegin = yyn < 0 ? -yyn : 0;
            // Stay within bounds of both yycheck and yytname.
            int yychecklim = yylast_ - yyn + 1;
            int yyxend = yychecklim < yyntokens_ ? yychecklim : yyntokens_;
            for (int yyx = yyxbegin; yyx < yyxend; ++yyx)
              if (yycheck_[yyx + yyn] == yyx && yyx != yy_error_token_
                  && !yy_table_value_is_error_ (yytable_[yyx + yyn]))
                {
                  if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                    {
                      yycount = 1;
                      break;
                    }
                  else
                    yyarg[yycount++] = yytname_[yyx];
                }
          }
      }

    char const* yyformat = YY_NULLPTR;
    switch (yycount)
      {
#define YYCASE_(N, S)                         \
        case N:                               \
          yyformat = S;                       \
        break
      default: // Avoid compiler warnings.
        YYCASE_ (0, YY_("syntax error"));
        YYCASE_ (1, YY_("syntax error, unexpected %s"));
        YYCASE_ (2, YY_("syntax error, unexpected %s, expecting %s"));
        YYCASE_ (3, YY_("syntax error, unexpected %s, expecting %s or %s"));
        YYCASE_ (4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
        YYCASE_ (5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
#undef YYCASE_
      }

    std::string yyres;
    // Argument number.
    std::ptrdiff_t yyi = 0;
    for (char const* yyp = yyformat; *yyp; ++yyp)
      if (yyp[0] == '%' && yyp[1] == 's' && yyi < yycount)
        {
          yyres += yytnamerr_ (yyarg[yyi++]);
          ++yyp;
        }
      else
        yyres += *yyp;
    return yyres;
  }


  const signed char parser::yypact_ninf_ = -27;

  const signed char parser::yytable_ninf_ = -3;

  const signed char
  parser::yypact_[] =
  {
      54,   -27,    -8,     0,     9,    34,    12,   -27,   -27,    26,
     -27,    25,    42,   -27,    43,   -27,    55,    48,    56,   -27,
     -27,    27,   -27,    -2,    23,   -27,    27,    27,    74,   -27,
     -27,   -27,    27,    27,    72,   -27,   -27,    78,    56,    83,
      91,    40,    -7,    27,    14,    31,    27,    27,    27,    27,
      27,    27,    27,    27,   104,   116,   -27,   -27,   -27,    27,
      72,   121,    80,    87,    93,    98,    14,    14,    31,    62,
     -27,   113,    53,   -27,    27,   -27,   106,   -27,    27,    72,
      27,    72,    72
  };

  const signed char
  parser::yydefact_[] =
  {
       0,     8,     0,    10,     0,     0,     0,     5,     6,     7,
      14,     0,     0,     1,     0,     4,     0,     0,     0,     3,
      13,     0,    37,     0,     0,    30,     0,     0,    28,    39,
      38,    40,     0,     0,     9,    18,    29,     0,     0,     0,
       0,     0,     0,     0,    19,    20,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    36,    35,    15,     0,
      33,     0,    26,    27,    24,    25,    21,    22,    23,     0,
      11,     0,     0,    31,     0,    17,     0,    34,     0,    32,
       0,    16,    12
  };

  const signed char
  parser::yypgoto_[] =
  {
     -27,   -27,   -27,   123,   -27,   -27,   -27,   -27,   -27,   -26,
     -27,   -27,   -27,    92,   -27
  };

  const signed char
  parser::yydefgoto_[] =
  {
      -1,     4,     5,     6,     7,     8,    12,    76,     9,    34,
      35,    61,    23,    24,    36
  };

  const signed char
  parser::yytable_[] =
  {
      41,    42,    37,    59,    38,    10,    44,    45,    11,    13,
      46,    47,    48,    49,    50,    51,    52,    60,    53,    15,
      62,    63,    64,    65,    66,    67,    68,    69,    25,    39,
      26,    40,    16,    72,    -2,     1,    27,    52,    17,    53,
      28,    29,    30,    31,    58,    18,     2,     3,    79,    32,
      19,    33,    81,    21,    82,     1,    53,    46,    47,    48,
      49,    50,    51,    52,    78,    53,     2,     3,    20,    22,
      46,    47,    48,    49,    50,    51,    52,    43,    53,    46,
      47,    48,    49,    50,    51,    52,    54,    53,    75,    46,
      47,    48,    49,    50,    51,    52,    56,    53,    47,    48,
      49,    50,    51,    52,    57,    53,    48,    49,    50,    51,
      52,    80,    53,    49,    50,    51,    52,    70,    53,    50,
      51,    52,    39,    53,    71,    73,    77,    74,    14,     0,
      55
  };

  const signed char
  parser::yycheck_[] =
  {
      26,    27,     4,    10,     6,    13,    32,    33,     8,     0,
      17,    18,    19,    20,    21,    22,    23,    43,    25,     7,
      46,    47,    48,    49,    50,    51,    52,    53,     1,     6,
       3,     8,     6,    59,     0,     1,     9,    23,    13,    25,
      13,    14,    15,    16,     4,     3,    12,    13,    74,    22,
       7,    24,    78,     5,    80,     1,    25,    17,    18,    19,
      20,    21,    22,    23,    11,    25,    12,    13,    13,    13,
      17,    18,    19,    20,    21,    22,    23,     3,    25,    17,
      18,    19,    20,    21,    22,    23,     8,    25,    26,    17,
      18,    19,    20,    21,    22,    23,    13,    25,    18,    19,
      20,    21,    22,    23,    13,    25,    19,    20,    21,    22,
      23,     5,    25,    20,    21,    22,    23,    13,    25,    21,
      22,    23,     6,    25,     8,     4,    13,     6,     5,    -1,
      38
  };

  const signed char
  parser::yystos_[] =
  {
       0,     1,    12,    13,    28,    29,    30,    31,    32,    35,
      13,     8,    33,     0,    30,     7,     6,    13,     3,     7,
      13,     5,    13,    39,    40,     1,     3,     9,    13,    14,
      15,    16,    22,    24,    36,    37,    41,     4,     6,     6,
       8,    36,    36,     3,    36,    36,    17,    18,    19,    20,
      21,    22,    23,    25,     8,    40,    13,    13,     4,    10,
      36,    38,    36,    36,    36,    36,    36,    36,    36,    36,
      13,     8,    36,     4,     6,    26,    34,    13,    11,    36,
       5,    36,    36
  };

  const signed char
  parser::yyr1_[] =
  {
       0,    27,    28,    29,    29,    30,    30,    30,    30,    31,
      33,    34,    32,    35,    35,    36,    36,    36,    36,    36,
      36,    36,    36,    36,    36,    36,    36,    36,    36,    36,
      36,    37,    38,    38,    39,    39,    40,    40,    41,    41,
      41
  };

  const signed char
  parser::yyr2_[] =
  {
       0,     2,     1,     3,     2,     1,     1,     1,     1,     5,
       0,     0,    10,     3,     2,     3,     6,     4,     1,     2,
       2,     3,     3,     3,     3,     3,     3,     3,     1,     1,
       1,     4,     3,     1,     5,     3,     3,     1,     1,     1,
       1
  };



  // YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
  // First, the terminals, then, starting at \a yyntokens_, nonterminals.
  const char*
  const parser::yytname_[] =
  {
  "$end", "error", "$undefined", "PAR_IZQ", "PAR_DER", "ASIGN", "COMA",
  "PTOCOMA", "DOSPTOS", "IF", "THEN", "ELSE", "PLOT", "IDENT",
  "CONST_ENTERO", "CONST_BOOL", "CONST_REAL", "OP_OR", "OP_AND",
  "OP_IGUAL", "OP_COMP", "OP_SUMA", "OP_MENOS", "OP_MULTIP", "OP_NEG",
  "COR_IZQ", "COR_DER", "$accept", "programa", "lista_sentencias",
  "sentencia", "sentencia_declar_valor", "sentencia_declar_fun", "$@1",
  "$@2", "sentencia_plot", "expresion", "llamada_funcion",
  "lista_expresiones", "lista_param", "lista_ident", "constante", YY_NULLPTR
  };

#if YYDEBUG
  const signed char
  parser::yyrline_[] =
  {
       0,    47,    47,    50,    51,    54,    55,    56,    57,    60,
      63,    63,    63,    66,    67,    70,    71,    72,    73,    74,
      75,    76,    77,    78,    79,    80,    81,    82,    83,    84,
      85,    88,    91,    92,    95,    96,    99,   100,   103,   104,
     105
  };

  // Print the state stack on the debug stream.
  void
  parser::yystack_print_ ()
  {
    *yycdebug_ << "Stack now";
    for (stack_type::const_iterator
           i = yystack_.begin (),
           i_end = yystack_.end ();
         i != i_end; ++i)
      *yycdebug_ << ' ' << int (i->state);
    *yycdebug_ << '\n';
  }

  // Report on the debug stream that the rule \a yyrule is going to be reduced.
  void
  parser::yy_reduce_print_ (int yyrule)
  {
    int yylno = yyrline_[yyrule];
    int yynrhs = yyr2_[yyrule];
    // Print the symbols being reduced, and their result.
    *yycdebug_ << "Reducing stack by rule " << yyrule - 1
               << " (line " << yylno << "):\n";
    // The symbols being reduced.
    for (int yyi = 0; yyi < yynrhs; yyi++)
      YY_SYMBOL_PRINT ("   $" << yyi + 1 << " =",
                       yystack_[(yynrhs) - (yyi + 1)]);
  }
#endif // YYDEBUG

  parser::token_number_type
  parser::yytranslate_ (int t)
  {
    // YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to
    // TOKEN-NUM as returned by yylex.
    static
    const token_number_type
    translate_table[] =
    {
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26
    };
    const int user_token_number_max_ = 281;

    if (t <= 0)
      return yyeof_;
    else if (t <= user_token_number_max_)
      return translate_table[t];
    else
      return yy_undef_token_;
  }

} // yy
#line 1283 "y.tab.c"

#line 107 "semantico.y"


#include "lex.yy.c"
//#include "error.y"

namespace yy {
	auto parser::error(const std::string& msg) -> void {
		std::cerr << msg << '/n';
	}
}

void yyerror(const char* s) {
	printf("\n(Línea %d) %s\n", linea, s);
}

int main( int argc, char *argv[] ) {
  //yyin = abrir_entrada(argc,argv) ;
  initializeTS();
  
  yy::parser parse();
  
  return parse() ;
}
