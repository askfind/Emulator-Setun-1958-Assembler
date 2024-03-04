#
# Filename: "oper_trit_test.s"
#
# Project: Троичная МЦВМ "Сетунь" 1958 года на языке ассемблера RISC-V
#
# Create date: 03.03.2024
# Edit date:   03.03.2023
#
# Author:      Vladimir V.
# E-mail:      askfind@ya.ru
#
# GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
#


# ----------------------------------------------------
# AND_t tests(...)
#

.macro and_t_test

.data
and_t_tests:
.string	"AND_t tests(...) :\n"        
.text   
        logs(and_t_tests)

.data
and_t_ts1:
.string	"and_t(-1,-1)->"
.text
        logs(and_t_ts1)
        and_t(-1,-1)
        put
.data
and_t_ts2:
.string	"and_t(-1,0)->"        
.text
        logs(and_t_ts2)
        and_t(-1,0)
        put
.data
and_t_ts3:
.string	"and_t(-1,1)->"        
.text        
        logs(and_t_ts3)
        and_t(-1,1)
        put
.data
and_t_ts4:
.string	"and_t(0,-1)->"        
.text        
        logs(and_t_ts4)
        and_t(0,-1)
	put
.data
and_t_ts5:
.string	"and_t(0,0)->"        
.text       
        logs(and_t_ts5)
        and_t(0,0)
	put
.data
and_t_ts6:
.string	"and_t(0,1)->"        
.text
        logs(and_t_ts6)
        and_t(0,1)
	put
.data
and_t_ts7:
.string	"and_t(1,-1)->"        
.text
        logs(and_t_ts7)
        and_t(1,-1)
	put
.data
and_t_ts8:
.string	"and_t(1,0)->"        
.text
        logs(and_t_ts8)
        and_t(1,0)
	put
.data
and_t_ts9:
.string	"and_t(1,1)->"        
.text
        logs(and_t_ts9)
        and_t(1,1)
	put

.end_macro


# ----------------------------------------------------
# OR_t tests(...)
#

.macro or_t_test

.data
or_t_tests:
.string	"OR_t tests(...) :\n"        
.text   
        logs(or_t_tests)

.data
or_t_ts1:
.string	"or_t(-1,-1)->"
.text
        logs(or_t_ts1)
        or_t(-1,-1)
        put
.data
or_t_ts2:
.string	"or_t(-1,0)->"        
.text
        logs(or_t_ts2)
        or_t(-1,0)
        put
.data
or_t_ts3:
.string	"or_t(-1,1)->"        
.text        
        logs(or_t_ts3)
        or_t(-1,1)
        put
.data
or_t_ts4:
.string	"or_t(0,-1)->"        
.text        
        logs(or_t_ts4)
        or_t(0,-1)
	put
.data
or_t_ts5:
.string	"or_t(0,0)->"        
.text       
        logs(or_t_ts5)
        or_t(0,0)
	put
.data
or_t_ts6:
.string	"or_t(0,1)->"        
.text
        logs(or_t_ts6)
        or_t(0,1)
	put
.data
or_t_ts7:
.string	"or_t(1,-1)->"        
.text
        logs(or_t_ts7)
        or_t(1,-1)
	put
.data
or_t_ts8:
.string	"or_t(1,0)->"        
.text
        logs(or_t_ts8)
        or_t(1,0)
	put
.data
or_t_ts9:
.string	"or_t(1,1)->"        
.text
        logs(or_t_ts9)
        or_t(1,1)
	put

.end_macro

# ----------------------------------------------------
# XOR_t tests(...)
#

.macro xor_t_test

.data
xor_t_tests:
.string	"XOR_t tests(...) :\n"        
.text   
        logs(xor_t_tests)

.data
xor_t_ts1:
.string	"xor_t(-1,-1)->"
.text
        logs(xor_t_ts1)
        xor_t(-1,-1)
        put
.data
xor_t_ts2:
.string	"xor_t(-1,0)->"        
.text
        logs(xor_t_ts2)
        xor_t(-1,0)
        put
.data
xor_t_ts3:
.string	"xor_t(-1,1)->"        
.text        
        logs(xor_t_ts3)
        xor_t(-1,1)
        put
.data
xor_t_ts4:
.string	"xor_t(0,-1)->"        
.text        
        logs(xor_t_ts4)
        xor_t(0,-1)
	put
.data
xor_t_ts5:
.string	"xor_t(0,0)->"        
.text       
        logs(xor_t_ts5)
        xor_t(0,0)
	put
.data
xor_t_ts6:
.string	"xor_t(0,1)->"        
.text
        logs(xor_t_ts6)
        xor_t(0,1)
	put
.data
xor_t_ts7:
.string	"xor_t(1,-1)->"        
.text
        logs(xor_t_ts7)
        xor_t(1,-1)
	put
.data
xor_t_ts8:
.string	"xor_t(1,0)->"        
.text
        logs(xor_t_ts8)
        xor_t(1,0)
	put
.data
xor_t_ts9:
.string	"xor_t(1,1)->"        
.text
        logs(xor_t_ts9)
        xor_t(1,1)
	put

.end_macro
