:: The ctr algorithm is divided into 2 parts. The first part,
:: is a simple greedy algorithm which ties to find offsets
:: for each involved prime, so that the desired number range
:: has at least prime candidates as possible.
::
:: The second part is an evolutionary algorithm, which tries to improve the
:: results form the greedy algorithm. Therefor the greedy algorithm
:: will be executed several times with slightly different parameters, to produce
:: ctrs which differs in quality, which than can be used by the evolutionary algorithm.
::
:: The output is a text file which can be used by gapminer as an input for ctr sieving.
::
:: Parameter description:
::
::
:: --calc-ctr          Indicates that we want to calculate a ctr file.
::
:: --ctr-strength      This is used to variate the computing time spend
::                     within the greedy algorithm. Higher strength
::                     can yield better results.
::
:: --ctr-primes        The number of primes to use in the ctr file. The more
::                     primes the better the ctr result, but the shift
::                     also increases. Minimum shift can be calculated as
::                     the binary logarithm of the product of all primes:
::                     log2(p1 * p2 * ... *pn).
::
:: --ctr-evolution     Whether to use the evolutionary algorithm or not.
::
:: --ctr-fixed         This number indicates the number of starting primes
::                     which wound get touched by the evolutionary algorithm
::                     the offsets for the primes 2,3,5,7,11... are mostly
::                     perfect computed by the greedy algorithm, and changing
::                     them only declines the result.
::
:: --ctr-ivs           The number of individuals used in the evolutionary algorithm.
::                     More increases computing time but mostly also the
::                     result quality.
::
:: --ctr-range         Percent deviation from the number of primes.
::                     Useful if you don't want to look for a specific number
::                     of primes.
::
:: --ctr-bits -256         The shift value you later use for sieving has to be greater
::                     than log2(p1*p2*..*pn). With this flag you can fine tune a specific
::                     shift by setting this to shift - log2(p1*p2*..*pn).
::
:: --ctr-merit         The target merit (while testing the ctr it seamed that
::                     sieving for target-merit - 1 yields the best results)
::
:: --ctr-file          The target ctr output file. You can open this with a
::                     text editor. Look for the n_candidates value, the smaller
::                     it is the better the ctr file.
::
::
::
::
:: Example settings which were used to calculate the current ctr files:
:: You can touch: --ctr-strength ; --ctr-merit (decimal allowed); --ctr-ivs ; --ctr-range ; -t ; --ctr-file
:: You can't touch:  --ctr-fixed ; --ctr-bits
::
::
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 10 --ctr-primes 14 -t 16 --ctr-file m22/crt-22m-0064s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 10 --ctr-primes 15 -t 16 --ctr-file m22/crt-22m-0070s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 16 -t 16 --ctr-file m22/crt-22m-0077s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 17 -t 16 --ctr-file m22/crt-22m-0083s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 18 -t 16 --ctr-file m22/crt-22m-0090s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 19 -t 16 --ctr-file m22/crt-22m-0096s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 20 -t 16 --ctr-file m22/crt-22m-0102s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 21 -t 16 --ctr-file m22/crt-22m-0109s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 22 -t 16 --ctr-file m22/crt-22m-0115s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 23 -t 16 --ctr-file m22/crt-22m-0122s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 24 -t 16 --ctr-file m22/crt-22m-0128s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 25 -t 16 --ctr-file m22/crt-22m-0134s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 26 -t 16 --ctr-file m22/crt-22m-0141s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 27 -t 16 --ctr-file m22/crt-22m-0147s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 28 -t 16 --ctr-file m22/crt-22m-0154s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 29 -t 16 --ctr-file m22/crt-22m-0160s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 30 -t 16 --ctr-file m22/crt-22m-0166s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 31 -t 16 --ctr-file m22/crt-22m-0173s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 10 --ctr-primes 32 -t 16 --ctr-file m22/crt-22m-0179s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 10 --ctr-primes 33 -t 16 --ctr-file m22/crt-22m-0186s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 9 --ctr-primes 34 -t 16 --ctr-file m22/crt-22m-0192s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 10 --ctr-primes 35 -t 16 --ctr-file m22/crt-22m-0200s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 36 -t 16 --ctr-file m22/crt-22m-0208s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 37 -t 16 --ctr-file m22/crt-22m-0216s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 38 -t 16 --ctr-file m22/crt-22m-0224s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 39 -t 16 --ctr-file m22/crt-22m-0232s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 40 -t 16 --ctr-file m22/crt-22m-0240s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 41 -t 16 --ctr-file m22/crt-22m-0248s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 42 -t 16 --ctr-file m22/crt-22m-0256s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 43 -t 16 --ctr-file m22/crt-22m-0264s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 44 -t 16 --ctr-file m22/crt-22m-0272s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 45 -t 16 --ctr-file m22/crt-22m-0280s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 46 -t 16 --ctr-file m22/crt-22m-0288s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 47 -t 16 --ctr-file m22/crt-22m-0296s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 48 -t 16 --ctr-file m22/crt-22m-0304s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 17 --ctr-primes 49 -t 16 --ctr-file m22/crt-22m-0312s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 50 -t 16 --ctr-file m22/crt-22m-0320s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 51 -t 16 --ctr-file m22/crt-22m-0326s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 52 -t 16 --ctr-file m22/crt-22m-0333s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 53 -t 16 --ctr-file m22/crt-22m-0339s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 54 -t 16 --ctr-file m22/crt-22m-0346s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 9 --ctr-primes 55 -t 16 --ctr-file m22/crt-22m-0352s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 56 -t 16 --ctr-file m22/crt-22m-0362s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 57 -t 16 --ctr-file m22/crt-22m-0373s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 58 -t 16 --ctr-file m22/crt-22m-0384s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 17 --ctr-primes 59 -t 16 --ctr-file m22/crt-22m-0392s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 17 --ctr-primes 60 -t 16 --ctr-file m22/crt-22m-0400s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 61 -t 16 --ctr-file m22/crt-22m-0408s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 62 -t 16 --ctr-file m22/crt-22m-0416s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 63 -t 16 --ctr-file m22/crt-22m-0424s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 64 -t 16 --ctr-file m22/crt-22m-0432s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 65 -t 16 --ctr-file m22/crt-22m-0440s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 66 -t 16 --ctr-file m22/crt-22m-0448s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 67 -t 16 --ctr-file m22/crt-22m-0456s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 68 -t 16 --ctr-file m22/crt-22m-0464s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 69 -t 16 --ctr-file m22/crt-22m-0472s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 70 -t 16 --ctr-file m22/crt-22m-0480s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 71 -t 16 --ctr-file m22/crt-22m-0488s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 72 -t 16 --ctr-file m22/crt-22m-0496s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 73 -t 16 --ctr-file m22/crt-22m-0504s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 74 -t 16 --ctr-file m22/crt-22m-0512s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 75 -t 16 --ctr-file weak/crt-22m-0520s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 10 --ctr-primes 76 -t 16 --ctr-file weak/crt-22m-0528s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 10 --ctr-primes 77 -t 16 --ctr-file weak/crt-22m-0536s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 9 --ctr-primes 78 -t 16 --ctr-file weak/crt-22m-0544s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 79 -t 16 --ctr-file weak/crt-22m-0555s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 80 -t 16 --ctr-file weak/crt-22m-0565s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 81 -t 16 --ctr-file weak/crt-22m-0576s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 82 -t 16 --ctr-file weak/crt-22m-0584s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 83 -t 16 --ctr-file weak/crt-22m-0592s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 84 -t 16 --ctr-file weak/crt-22m-0600s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 85 -t 16 --ctr-file weak/crt-22m-0608s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 86 -t 16 --ctr-file weak/crt-22m-0619s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 87 -t 16 --ctr-file weak/crt-22m-0629s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 17 --ctr-primes 88 -t 16 --ctr-file weak/crt-22m-0640s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 17 --ctr-primes 89 -t 16 --ctr-file weak/crt-22m-0648s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 90 -t 16 --ctr-file weak/crt-22m-0656s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 91 -t 16 --ctr-file weak/crt-22m-0664s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 92 -t 16 --ctr-file weak/crt-22m-0672s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 93 -t 16 --ctr-file weak/crt-22m-0680s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 94 -t 16 --ctr-file weak/crt-22m-0688s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 95 -t 16 --ctr-file weak/crt-22m-0696s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 10 --ctr-primes 96 -t 16 --ctr-file weak/crt-22m-0704s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 97 -t 16 --ctr-file weak/crt-22m-0715s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 98 -t 16 --ctr-file weak/crt-22m-0725s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 99 -t 16 --ctr-file weak/crt-22m-0736s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 100 -t 16 --ctr-file weak/crt-22m-0744s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 101 -t 16 --ctr-file weak/crt-22m-0752s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 102 -t 16 --ctr-file weak/crt-22m-0760s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 103 -t 16 --ctr-file weak/crt-22m-0768s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 104 -t 16 --ctr-file weak/crt-22m-0779s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 105 -t 16 --ctr-file weak/crt-22m-0789s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 106 -t 16 --ctr-file weak/crt-22m-0800s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 107 -t 16 --ctr-file weak/crt-22m-0808s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 108 -t 16 --ctr-file weak/crt-22m-0816s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 109 -t 16 --ctr-file weak/crt-22m-0824s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 110 -t 16 --ctr-file weak/crt-22m-0832s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 111 -t 16 --ctr-file weak/crt-22m-0843s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 112 -t 16 --ctr-file weak/crt-22m-0853s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 113 -t 16 --ctr-file weak/crt-22m-0864s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 114 -t 16 --ctr-file weak/crt-22m-0872s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 115 -t 16 --ctr-file weak/crt-22m-0880s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 116 -t 16 --ctr-file weak/crt-22m-0888s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 10 --ctr-primes 117 -t 16 --ctr-file weak/crt-22m-0896s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 118 -t 16 --ctr-file weak/crt-22m-0907s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 14 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 119 -t 16 --ctr-file weak/crt-22m-0917s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 15 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 120 -t 16 --ctr-file weak/crt-22m-0928s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 15 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 121 -t 16 --ctr-file weak/crt-22m-0938s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 15 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 122 -t 16 --ctr-file weak/crt-22m-0949s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 15 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 123 -t 16 --ctr-file weak/crt-22m-0956s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 15 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 124 -t 16 --ctr-file weak/crt-22m-0965s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 15 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 125 -t 16 --ctr-file weak/crt-22m-0974s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 15 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 126 -t 16 --ctr-file weak/crt-22m-0983s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 15 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 127 -t 16 --ctr-file weak/crt-22m-0992s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 15 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 128 -t 16 --ctr-file weak/crt-22m-1003s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 15 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 129 -t 16 --ctr-file weak/crt-22m-1013s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 15 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 130 -t 16 --ctr-file weak/crt-22m-1024s-wizz.txt
::
::pause
::
