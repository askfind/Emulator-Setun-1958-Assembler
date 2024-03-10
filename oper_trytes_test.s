#
# Filename: "oper_trytes_test.s"
#
# Project: Троичная МЦВМ "Сетунь" 1958 года на языке ассемблера RISC-V
#
# Create date: 03.03.2024
# Edit date:   10.03.2024
#
# Author:      Vladimir V.
# E-mail:      askfind@ya.ru
#
# GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
#

.macro trs_t_test

.data
trs_t_tests:
.string	"TRS_t tests(...) :\n"        
.text   
        logs(trs_t_tests)
#
.data
clean_trs_t1:
.string	"a0=0xAAAA, a1=0xBBBB; clean_trs(a0,a1)->"
.text
        logs(clean_trs_t1)
        li a0,0xAAAA
        li a1,0xBBBB
        clean_trs(a0,a1)
        logi
        mv a0,a1
        logi
        loglf
#
.data
get_trit_t2:
.string	"ts1=0x1, ts0=0x1,pos=0; get_trit(ts1,ts0,pos)->"
.text
        logs(get_trit_t2)
        li a1,0x1
        li a0,0x1
        li a3,0
        get_trit(a1,a0,a3)
        logi
        loglf
#
.data
get_trit_t3:
.string	"ts1=0x0, ts0=0x1,pos=0; get_trit(ts1,ts0,pos)->"
.text
        logs(get_trit_t3)
        li a1,0x0
        li a0,0x1
        li a3,0
        get_trit(a1,a0,a3)
        logi
        loglf

#
.data
get_trit_t4:
.string	"ts1=0x0, ts0=0x0,pos=0; get_trit(ts1,ts0,pos)->"
.text
        logs(get_trit_t4)
        li a1,0x0
        li a0,0x0
        li a3,0
        get_trit(a1,a0,a3)
        logi
        loglf

#
.data
get_trit_t5:
.string	"ts1=0x4, ts0=0x4,pos=2; get_trit(ts1,ts0,pos)->"
.text
        logs(get_trit_t5)
        li a1,0x4
        li a0,0x4
        li a3,2
        get_trit(a1,a0,a3)
        logi
        loglf

#
.data
get_trit_t6:
.string	"ts1=0x0, ts0=0x4,pos=2; get_trit(ts1,ts0,pos)->"
.text
        logs(get_trit_t6)
        li a1,0x0
        li a0,0x4
        li a3,2
        get_trit(a1,a0,a3)
        logi
        loglf

#
.data
get_trit_t7:
.string	"ts1=0x0, ts0=0x0,pos=2; get_trit(ts1,ts0,pos)->"
.text
        logs(get_trit_t7)
        li a1,0x0
        li a0,0x0
        li a3,2
        get_trit(a1,a0,a3)        
        logi
        loglf
#
.data
set_trit_t8:
.string	"ts1=0x0000, ts0=0x0000, pos=5, val=-1; set_trit(ts1,ts0,pos,val)->"
.text
        logs(set_trit_t8)
        li a1,0x0000
        li a0,0x0000
        li a2,5
        li a3,-1
        set_trit(a0,a1,a2,a3)
        
        view_trs(a1,a0)
#
.data
set_trit_t9:
.string	"ts1=0x0000, ts0=0x0000, pos=5, val=0; set_trit(ts1,ts0,pos,val)->"
.text
        logs(set_trit_t9)
        li a1,0x0000
        li a0,0x0000
        li a2,5
        li a3,0
        set_trit(a0,a1,a2,a3)
        
        view_trs(a1,a0)

#
.data
set_trit_t10:
.string	"ts1=0x0000, ts0=0x0000, pos=5, val=+1; set_trit(ts1,ts0,pos,val)->"
.text
        logs(set_trit_t10)
        li a1,0x0000
        li a0,0x0000
        li a2,5
        li a3,1
        set_trit(a0,a1,a2,a3)
        
        view_trs(a1,a0)
#
.data
shift_trs_t11:
.string	"ts1=0x0080, ts0=0x0080, shift=+2; shift_trs(ts1,ts0, shift)->"
.text
        logs(shift_trs_t11)
        li a1,0x0080
        li a0,0x0080
        li a2,2        
        shift_trs(a0,a1,a2)
        
        view_trs(a1,a0)
#
.data
shift_trs_t12:
.string	"ts1=0x0080, ts0=0x0080, shift=-3; shift_trs(ts1,ts0, shift)->"
.text
        logs(shift_trs_t12)
        li a1,0x0080
        li a0,0x0080
        li a2,-3        
        shift_trs(a0,a1,a2)
        
        view_trs(a1,a0)
#
.data
slice_trs_t13:
.string	"ts1=0x0100, ts0=0x0100, pos1=8,pos2=4;  slice_trs ($ts1,$ts0,$pos1,$pos2)->"
.text
        logs(slice_trs_t13)
        li a1,0x0100
        li a0,0x0100
        li a2,8
        li a3,4        
        slice_trs(a0,a1,a2,a3)
        
        view_trs(a1,a0)
#
.data
and_trs_t14:
.string	"tryte1.1=0xFF00, tryte1.0=0xFFFF, tryte2.1=0x00FF, tryte2.0=0xFFFF;  and_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->"
.text
        logs(and_trs_t14)
        li a1,0xFF00
        li a0,0xFFFF
        li a3,0x00FF
        li a2,0xFFFF
        and_trs(a0,a1,a2,a3)

        view_trs(a1,a0)
#
.data
and_trs_t15:
.string	"tryte1.1=0xFF00, tryte1.0=0xFFFF, tryte2.1=0x0000, tryte2.0=0x0000;  and_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->"
.text
        logs(and_trs_t15)
        li a1,0xFF00
        li a0,0xFFFF
        li a3,0x0000
        li a2,0x0000
        and_trs(a0,a1,a2,a3)

        view_trs(a1,a0)
#
.data
or_trs_t16:
.string	"tryte1.1=0xFF00, tryte1.0=0xFFFF, tryte2.1=0x00FF, tryte2.0=0xFFFF;  or_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->"
.text
        logs(or_trs_t16)
        li a1,0xFF00
        li a0,0xFFFF
        li a3,0x00FF
        li a2,0xFF00
        or_trs(a0,a1,a2,a3)

        view_trs(a1,a0)
#
.data
or_trs_t17:
.string	"tryte1.1=0xFF00, tryte1.0=0xFFFF, tryte2.1=0x0000, tryte2.0=0x0000;  or_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->"
.text
        logs(or_trs_t17)
        li a1,0xFF00
        li a0,0xFFFF
        li a3,0x0000
        li a2,0x0000
        or_trs(a0,a1,a2,a3)

        view_trs(a1,a0)
#
.data
xor_trs_t18:
.string	"tryte1.1=0xFF00, tryte1.0=0xFFFF, tryte2.1=0x00FF, tryte2.0=0xFFFF;  xor_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->"
.text
        logs(xor_trs_t18)
        li a1,0xFF00
        li a0,0xFFFF
        li a3,0x00FF
        li a2,0xFF00
        xor_trs(a0,a1,a2,a3)

        view_trs(a1,a0)
#
.data
xor_trs_t19:
.string	"tryte1.1=0xFF00, tryte1.0=0xFFFF, tryte2.1=0x0000, tryte2.0=0x0000;  xor_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->"
.text
        logs(xor_trs_t19)
        li a1,0xFF00
        li a0,0xFFFF
        li a3,0x0000
        li a2,0x0000
        xor_trs(a0,a1,a2,a3)

        view_trs(a1,a0)
#
.data
not_trs_t20:
.string	"tryte1.1=0x0000, tryte1.0=0x00FF;  not_trs ($tryte1_1,$tryte1_0)->"
.text
        logs(not_trs_t20)
        li a1,0x0000
        li a0,0x00FF
        not_trs(a1,a0)

        view_trs(a1,a0)

#
.data
add_trs_t21:
.string	"tryte1.1=0x0001, tryte1.0=0x0001, tryte2.1=0x0001, tryte2.0=0x0001;  add_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->"
.text
        logs(add_trs_t21)
        li a1,0x0001
        li a0,0x0001
        li a3,0x0001
        li a2,0x0001
        add_trs(a1,a0,a3,a2)

        view_trs(a1,a0)

#
.data
add_trs_t22:
.string	"tryte1.1=0x0000, tryte1.0=0x0001, tryte2.1=0x0000, tryte2.0=0x0001;  add_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->"
.text
        logs(add_trs_t22)
        li a1,0x0000
        li a0,0x0001
        li a3,0x0000
        li a2,0x0001
        add_trs(a1,a0,a3,a2)

        view_trs(a1,a0)
#
.data
sub_trs_t23:
.string	"tryte1.1=0x0002, tryte1.0=0x0002, tryte2.1=0x0001, tryte2.0=0x0001;  sub_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->"
.text
        logs(sub_trs_t23)
        li a1,0x0002
        li a0,0x0002
        li a3,0x0001
        li a2,0x0001
        sub_trs(a1,a0,a3,a2)

        view_trs(a1,a0)
#
.data
sub_trs_t24:
.string	"tryte1.1=0x0000, tryte1.0=0x0001, tryte2.1=0x0000, tryte2.0=0x0001;  sub_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->"
.text
        logs(sub_trs_t24)
        li a1,0x0000
        li a0,0x0001
        li a3,0x0000
        li a2,0x0001
        sub_trs(a1,a0,a3,a2)
        
        view_trs(a1,a0)
#
.data
inc_trs_t25:
.string	"tryte1.1=0x0004, tryte1.0=0x0004;  inc_trs ($tryte1_1,$tryte1_0)->"
.text
        logs(inc_trs_t25)
        li a1,0x0004
        li a0,0x0004
        inc_trs(a1,a0)

        view_trs(a1,a0)

#
.data
dec_trs_t26:
.string	"tryte1.1=0x0004, tryte1.0=0x0004;  dec_trs ($tryte1_1,$tryte1_0)->"
.text
        logs(dec_trs_t26)
        li a1,0x0004
        li a0,0x0004
        dec_trs(a1,a0)
        
        view_trs(a1,a0)

# --------
.end_macro

