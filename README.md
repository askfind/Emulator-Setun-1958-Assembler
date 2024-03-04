# Emulator-Setun-1958-Assembler

Эмулятор троичной машины 'СЕТУНЬ' SETUN-1958 VM на языке Assembler

A virtual machine of ternary computer Setun, also known as "Small Automatic Digital Machine" written on Assembler.


## 1. История

- Дата создания:            02.03.2024
- Дата редактирования:      03.03.2024
- Версия:                   0.03
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

## 3. Проичные операции над тритами

### 3.1. Операция AND для тритов

```
AND_t tests(...) :
 and_t(-1,-1)->-1
 and_t(-1,0)->-1
 and_t(-1,1)->-1
 and_t(0,-1)->-1
 and_t(0,0)->0
 and_t(0,1)->0
 and_t(1,-1)->-1
 and_t(1,0)->0
 and_t(1,1)->1
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