# Emulator-Setun-1958-Assembler

Эмулятор троичной машины 'СЕТУНЬ' SETUN-1958 VM на языке Assembler

A virtual machine of ternary computer Setun, also known as "Small Automatic Digital Machine" written on Assembler.


## 1. История

- Дата создания:            02.03.2024
- Дата редактирования:      11.03.2024
- Версия:                   0.15
- Автор:                    Vladimir V.
- E-mail:                   askfind@ya.ru


## 2. Запуск эмулятора SETUN-1958

### RARS -- RISC-V Assembler and Runtime Simulator

RARS, the RISC-V Assembler, Simulator, and Runtime, will assemble and simulate
the execution of RISC-V assembly language programs. Its primary goal is to be
an effective development environment for people getting started with RISC-V.

```shell
~rars$ java -jar rars.jar ./app_trits/setun1958asm.s
RARS 1.6  Copyright 2003-2019 Pete Sanderson and Kenneth Vollmar

Ternary small digital computer 'Setun' on RISC-V

Program terminated by calling exit
```

## 3. Троичные операции над тритами

### 3.1. Операция AND для тритов

```
AND_t tests(...) :
 and_t(-1,-1)->-1
 and_t(-1,0)->-1
 and_t(-1,1)->-1
 and_t(0,-1)->0
 and_t(0,0)->0
 and_t(0,1)->0
 and_t(1,-1)->1
 and_t(1,0)->1
 and_t(1,1)->1
```

### 3.2. Троичная операция OR для тритов

```
 OR_t tests(...) :
 or_t(-1,-1)->-1
 or_t(-1,0)->-1
 or_t(-1,1)->-1
 or_t(0,-1)->0
 or_t(0,0)->0
 or_t(0,1)->0
 or_t(1,-1)->1
 or_t(1,0)->1
 or_t(1,1)->1
 ```

### 3.3. Троичная операция XOR для тритов

```
 XOR_t tests(...) :
 xor_t(-1,-1)->-1
 xor_t(-1,0)->-1
 xor_t(-1,1)->-1
 xor_t(0,-1)->0
 xor_t(0,0)->0
 xor_t(0,1)->0
 xor_t(1,-1)->-1
 xor_t(1,0)->-1
 xor_t(1,1)->-1
```

### 3.4. Троичная операция NOT для тритов

```
 NOT_t tests(...) :
 not_t(-1)->1
 not_t(0)->0
 not_t(1)->-1
```

### 3.5. Троичная операция SUM_HALF полусумматор для тритов

```
 SUM_HALF_t tests(...) :
 sum_half_t(-1,-1)->1
 sum_half_t(-1,0)->-1
 sum_half_t(-1,1)->0
 sum_half_t(0,-1)->-1
 sum_half_t(0,0)->0
 sum_half_t(0,1)->1
 sum_half_t(1,-1)->0
 sum_half_t(1,0)->1
 sum_half_t(1,1)->-1
```

### 3.6. Троичная операция SUM_t полный троичный сумматор для тритов

```
 SUM_t_tests(...) :
 sum_t(-1,-1,-1)->0 -1
 sum_t(-1,-1,0)->1 -1
 sum_t(1,1,0)->-1 1
 sum_t(1,1,1)->0 1
```

### 3.7. Операции над троичными числами TRS_t

### 3.7.1. Операция над троичными числами clean_trs

```
 a0=0xAAAA, a1=0xBBBB; clean_trs(a0,a1)->0 0
```

### 3.7.2. Операция над троичными числами get_trit
```
 ts1=0x1, ts0=0x1,pos=0; get_trit(ts1,ts0,pos)->1
 ts1=0x0, ts0=0x1,pos=0; get_trit(ts1,ts0,pos)->-1
 ts1=0x0, ts0=0x0,pos=0; get_trit(ts1,ts0,pos)->0
 ts1=0x4, ts0=0x4,pos=2; get_trit(ts1,ts0,pos)->1
 ts1=0x0, ts0=0x4,pos=2; get_trit(ts1,ts0,pos)->-1
 ts1=0x0, ts0=0x0,pos=2; get_trit(ts1,ts0,pos)->0

```

### 3.7.3. Операция над троичными числами set_trit
```
 ts1=0x0000, ts0=0x0000, pos=5, val=-1; set_trit(ts1,ts0,pos,val)->trs : [00000000000000000000000000-00000]
 ts1=0x0000, ts0=0x0000, pos=5, val=0; set_trit(ts1,ts0,pos,val)->trs : [00000000000000000000000000000000]
 ts1=0x0000, ts0=0x0000, pos=5, val=+1; set_trit(ts1,ts0,pos,val)->trs : [00000000000000000000000000+00000]
```

### 3.7.4. Операция над троичными числами shift_trs
```
 ts1=0x0080, ts0=0x0080, shift=+2; shift_trs(ts1,ts0, shift)->trs : [000000000000000000000000+0000000]
 ts1=0x0080, ts0=0x0080, shift=-3; shift_trs(ts1,ts0, shift)->trs : [000000000000000000000000000+0000]
```

### 3.7.5. Операция над троичными числами slice_trs
```
 ts1=0x0100, ts0=0x0100, pos1=8,pos2=4;  slice_trs ($ts1,$ts0,$pos1,$pos2)->trs : [000000000000000000000000000+0000]
```

### 3.7.6. Операция над троичными числами and_trs
```
 tryte1.1=0xFF00, tryte1.0=0xFFFF, tryte2.1=0x00FF, tryte2.0=0xFFFF;  and_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->trs : [00000000000000000000000000+00000]
 tryte1.1=0xFF00, tryte1.0=0xFFFF, tryte2.1=0x0000, tryte2.0=0x0000;  and_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->trs : [00000000000000000000000000+00000]
```

### 3.7.7. Операция над троичными числами or_trs
```
 tryte1.1=0xFF00, tryte1.0=0xFFFF, tryte2.1=0x00FF, tryte2.0=0xFFFF;  or_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->trs : [00000000000000000000000000+00000]
 tryte1.1=0xFF00, tryte1.0=0xFFFF, tryte2.1=0x0000, tryte2.0=0x0000;  or_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->trs : [00000000000000000000000000+00000]
```

### 3.7.8. Операция над троичными числами xor_trs
```
 tryte1.1=0xFF00, tryte1.0=0xFFFF, tryte2.1=0x00FF, tryte2.0=0xFFFF;  xor_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->trs : [00000000000000000000000000-00000]
 tryte1.1=0xFF00, tryte1.0=0xFFFF, tryte2.1=0x0000, tryte2.0=0x0000;  xor_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->trs : [00000000000000000000000000-00000]```

### 3.7.9. Операция над троичными числами not_trs
```
tryte1.1=0x0000, tryte1.0=0x00FF;  not_trs ($tryte1_1,$tryte1_0)->trs : [000000000000000000000000++++++++]
```

### 3.7.10. Операция над троичными числами add_trs
```
 tryte1.1=0x0001, tryte1.0=0x0001, tryte2.1=0x0001, tryte2.0=0x0001;  add_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->trs : [000000000000000000000000000000+-]
 tryte1.1=0x0000, tryte1.0=0x0001, tryte2.1=0x0000, tryte2.0=0x0001;  add_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->trs : [000000000000000000000000000000-+]
```

### 3.7.11. Операция над троичными числами sub_trs
```
 tryte1.1=0x0002, tryte1.0=0x0002, tryte2.1=0x0001, tryte2.0=0x0001;  sub_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->trs : [000000000000000000000000000000+-]
 tryte1.1=0x0000, tryte1.0=0x0001, tryte2.1=0x0000, tryte2.0=0x0001;  sub_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)->trs : [00000000000000000000000000000000]
```

### 3.7.12. Операция над троичными числами inc_trs
```
 tryte1.1=0x0004, tryte1.0=0x0004;  inc_trs ($tryte1_1,$tryte1_0)->trs : [00000000000000000000000000000+0+]
```

### 3.7.13. Операция над троичными числами dec_trs
```
 tryte1.1=0x0004, tryte1.0=0x0004;  dec_trs ($tryte1_1,$tryte1_0)->trs : [00000000000000000000000000000+0-]
```


# Ссылки

 1. *Materials on ternary computer science* - <http://ternarycomp.cs.msu.su/>
 2. *Emulator of the first ternary Soviet "Setun"* - <http://trinary.su/projects/>
 3. *Unique Setun based on the ternary code* - <https://habr.com/ru/company/ua-hosting/blog/273929/>
 4. *Group users in social network VK* - <https://vk.com/setunsu/>
 5. *Group users in social network Telegram* - <https://t.me/setun_1958/>
 6. *RARS -- RISC-V Assembler and Runtime Simulator* - Documentation for supported

  * [instructions](https://github.com/TheThirdOne/rars/wiki/Supported-Instructions),
  * [system calls](https://github.com/TheThirdOne/rars/wiki/Environment-Calls),
  * [assembler directives](https://github.com/TheThirdOne/rars/wiki/Assembler-Directives) and
  *
  * more can be found on the [wiki](https://github.com/TheThirdOne/rars/wiki).
    Documentation included in the download can be accessed via the help menu.

# Contributing

Everybody is invited and welcome to contribute to Setun VM.

Приглашаем всех желающих внести свой посильный вклад в эмулятор SETUN-1958.
