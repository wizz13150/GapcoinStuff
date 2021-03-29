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
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 10 --ctr-primes 14 -t 16 --ctr-file m25/crt-25m-0064s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 10 --ctr-primes 15 -t 16 --ctr-file m25/crt-25m-0070s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 16 -t 16 --ctr-file m25/crt-25m-0077s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 17 -t 16 --ctr-file m25/crt-25m-0083s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 18 -t 16 --ctr-file m25/crt-25m-0090s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 19 -t 16 --ctr-file m25/crt-25m-0096s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 20 -t 16 --ctr-file m25/crt-25m-0102s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 21 -t 16 --ctr-file m25/crt-25m-0109s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 22 -t 16 --ctr-file m25/crt-25m-0115s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 8 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 23 -t 16 --ctr-file m25/crt-25m-0122s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 24 -t 16 --ctr-file m25/crt-25m-0128s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 25 -t 16 --ctr-file m25/crt-25m-0134s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 26 -t 16 --ctr-file m25/crt-25m-0141s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 27 -t 16 --ctr-file m25/crt-25m-0147s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 28 -t 16 --ctr-file m25/crt-25m-0154s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 29 -t 16 --ctr-file m25/crt-25m-0160s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 30 -t 16 --ctr-file m25/crt-25m-0166s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 31 -t 16 --ctr-file m25/crt-25m-0173s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 10 --ctr-primes 32 -t 16 --ctr-file m25/crt-25m-0179s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 10 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 10 --ctr-primes 33 -t 16 --ctr-file m25/crt-25m-0186s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 9 --ctr-primes 34 -t 16 --ctr-file m25/crt-25m-0192s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 10 --ctr-primes 35 -t 16 --ctr-file m25/crt-25m-0200s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 36 -t 16 --ctr-file m25/crt-25m-0208s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 37 -t 16 --ctr-file m25/crt-25m-0216s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 38 -t 16 --ctr-file m25/crt-25m-0224s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 39 -t 16 --ctr-file m25/crt-25m-0232s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 40 -t 16 --ctr-file m25/crt-25m-0240s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 41 -t 16 --ctr-file m25/crt-25m-0248s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 42 -t 16 --ctr-file m25/crt-25m-0256s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 43 -t 16 --ctr-file m25/crt-25m-0264s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 44 -t 16 --ctr-file m25/crt-25m-0272s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 45 -t 16 --ctr-file m25/crt-25m-0280s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 46 -t 16 --ctr-file m25/crt-25m-0288s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 47 -t 16 --ctr-file m25/crt-25m-0296s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 48 -t 16 --ctr-file m25/crt-25m-0304s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 11 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 17 --ctr-primes 49 -t 16 --ctr-file m25/crt-25m-0312s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 50 -t 16 --ctr-file m25/crt-25m-0320s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 51 -t 16 --ctr-file m25/crt-25m-0326s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 52 -t 16 --ctr-file m25/crt-25m-0333s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 53 -t 16 --ctr-file m25/crt-25m-0339s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 54 -t 16 --ctr-file m25/crt-25m-0346s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 9 --ctr-primes 55 -t 16 --ctr-file m25/crt-25m-0352s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 56 -t 16 --ctr-file m25/crt-25m-0362s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 57 -t 16 --ctr-file m25/crt-25m-0373s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 58 -t 16 --ctr-file m25/crt-25m-0384s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 17 --ctr-primes 59 -t 16 --ctr-file m25/crt-25m-0392s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 17 --ctr-primes 60 -t 16 --ctr-file m25/crt-25m-0400s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 61 -t 16 --ctr-file m25/crt-25m-0408s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 62 -t 16 --ctr-file m25/crt-25m-0416s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 63 -t 16 --ctr-file m25/crt-25m-0424s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 64 -t 16 --ctr-file m25/crt-25m-0432s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 16 --ctr-primes 65 -t 16 --ctr-file m25/crt-25m-0440s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 66 -t 16 --ctr-file m25/crt-25m-0448s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 67 -t 16 --ctr-file m25/crt-25m-0456s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 68 -t 16 --ctr-file m25/crt-25m-0464s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 69 -t 16 --ctr-file m25/crt-25m-0472s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 70 -t 16 --ctr-file m25/crt-25m-0480s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 71 -t 16 --ctr-file m25/crt-25m-0488s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 72 -t 16 --ctr-file m25/crt-25m-0496s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 12 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 12 --ctr-primes 73 -t 16 --ctr-file m25/crt-25m-0504s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 13 --ctr-strength 10000 --ctr-merit 25 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 11 --ctr-primes 74 -t 16 --ctr-file m25/crt-25m-0512s-wizz.txt
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
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 15 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 13 --ctr-primes 128 -t 16 --ctr-file weak/crt-22m-01003s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 15 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 14 --ctr-primes 129 -t 16 --ctr-file weak/crt-22m-01013s-wizz.txt
::gapminer-cpu.exe --calc-ctr --ctr-evolution --ctr-fixed 15 --ctr-strength 10000 --ctr-merit 22 --ctr-ivs 1000 --ctr-range 0 --ctr-bits 15 --ctr-primes 130 -t 16 --ctr-file weak/crt-22m-01024s-wizz.txt
::
::pause
::

::
::Stratum parameters
::-o gap.suprnova.cc -p 2433 -u worker.worker -x pwd --stratum
::

::
::Standard miner (without CRT), choose a non-overmined shift
::Pool
::gapminer-cpu.exe -o gap.suprnova.cc -p 2433 -u worker.worker -x pwd --stratum --shift 64 --threads 12
::Solo
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --threads 12 --shift 64
::


::1/2
::School for more gaps/s and tests :
::
:: Instructions:
:: 1 - Set --fermat-threads = --threads minus one.
:: 2 - Set --sieve-primes for an optimal value.
:: 3 - Miners should use a random/different shift when starting CRT miner, choose a non-overmined shift.
:: You can mine in --shift 510, using the crt file 'crt-22m-512s.txt'.
::
::
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 64 --crt crtwizz/crt-22m-0064s.txt --threads 12 --fermat-threads 10 --sieve-primes 4400
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 70 --crt crtwizz/crt-22m-0070s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 4500
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 77 --crt crtwizz/crt-22m-0077s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 4600
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 83 --crt crtwizz/crt-22m-0083s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 4700
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 90 --crt crtwizz/crt-22m-0090s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 4800
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 96 --crt crtwizz/crt-22m-0096s.txt --threads 12 --fermat-threads 10 --sieve-primes 4900
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 102 --crt crtwizz/crt-22m-0102s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 5000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 109 --crt crtwizz/crt-22m-0109s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 5000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 115 --crt crtwizz/crt-22m-0115s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 5000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 122 --crt crtwizz/crt-22m-0122s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 5000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 128 --crt crtwizz/crt-22m-0128s-benxy031.txt --threads 12 --fermat-threads 10 --sieve-primes 8000  #22700 gaps/s 6.7M PPS 4.3M tests/s 0.08% t12 ft11 sp8000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 134 --crt crtwizz/crt-22m-0134s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 10000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 141 --crt crtwizz/crt-22m-0141s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 4500
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 147 --crt crtwizz/crt-22m-0147s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 4600 
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 154 --crt crtwizz/crt-22m-0154s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 4700
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 160 --crt crtwizz/crt-22m-0160s.txt --threads 12 --fermat-threads 11 --sieve-primes 5000  #16450 gaps/s 6.2M PPS 3.7M tests/s 0.07% t12 ft11 sp5000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 166 --crt crtwizz/crt-22m-0166s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 5000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 173 --crt crtwizz/crt-22m-0173s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 6000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 179 --crt crtwizz/crt-22m-0179s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 6000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 186 --crt crtwizz/crt-22m-0186s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 6000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 192 --crt crtwizz/crt-22m-0192s.txt --threads 12 --fermat-threads 11 --sieve-primes 6000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 200 --crt crtwizz/crt-22m-0200s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 6000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 208 --crt crtwizz/crt-22m-0208s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 7000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 216 --crt crtwizz/crt-22m-0216s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 7000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 224 --crt crtwizz/crt-22m-0224s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 8000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 232 --crt crtwizz/crt-22m-0232s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 8000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 240 --crt crtwizz/crt-22m-0240s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 8000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 248 --crt crtwizz/crt-22m-0248s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 8000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 256 --crt crtwizz/crt-22m-0256s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 11000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 264 --crt crtwizz/crt-22m-0264s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 11000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 272 --crt crtwizz/crt-22m-0272s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 11000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 280 --crt crtwizz/crt-22m-0280s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 11000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 288 --crt crtwizz/crt-22m-0288s.txt --threads 12 --fermat-threads 11 --sieve-primes 13000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 296 --crt crtwizz/crt-22m-0296s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 13000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 304 --crt crtwizz/crt-22m-0304s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 13000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 312 --crt crtwizz/crt-22m-0312s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 13000#fail
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 320 --crt crtwizz/crt-22m-0320s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 15000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 326 --crt crtwizz/crt-22m-0326s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 15000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 333 --crt crtwizz/crt-22m-0333s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 15000  #5000 gaps/s 14.2M PPS 1.9M tests/s 0.17% t12 ft11 sp15000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 339 --crt crtwizz/crt-22m-0339s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 15000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 346 --crt crtwizz/crt-22m-0346s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 15000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 352 --crt crtwizz/crt-22m-0352s.txt --threads 12 --fermat-threads 11 --sieve-primes 16000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 362 --crt crtwizz/crt-22m-0362s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 16000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 373 --crt crtwizz/crt-22m-0373s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 16000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 384 --crt crtwizz/crt-22m-0384s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 20000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 392 --crt crtwizz/crt-22m-0392s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 20000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 400 --crt crtwizz/crt-22m-0400s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 20000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 408 --crt crtwizz/crt-22m-0408s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 20000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 416 --crt crtwizz/crt-22m-0416s-pdazzl.txt --threads 12 --fermat-threads 11 --sieve-primes 23000  
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 424 --crt crtwizz/crt-22m-0424s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 23000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 432 --crt crtwizz/crt-22m-0432s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 23000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 440 --crt crtwizz/crt-22m-0440s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 23000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 448 --crt crtwizz/crt-22m-0448s.txt --threads 12 --fermat-threads 11 --sieve-primes 27000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 456 --crt crtwizz/crt-22m-0456s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 27000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 464 --crt crtwizz/crt-22m-0464s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 27000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 472 --crt crtwizz/crt-22m-0472s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 27000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 480 --crt crtwizz/crt-22m-0480s-pdazzl.txt --threads 12 --fermat-threads 11 --sieve-primes 32000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 488 --crt crtwizz/crt-22m-0488s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 32000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 496 --crt crtwizz/crt-22m-0496s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 32000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 504 --crt crtwizz/crt-22m-0504s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 32000  
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 512 --crt crtwizz/crt-22m-0512s-pdazzl.txt --threads 12 --fermat-threads 11 --sieve-primes 34000  #2330 gaps/s 27.5M PPS 1.1M tests/s 0.32% t12 ft11 sp34000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 520 --crt crtwizz/crt-22m-0520s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 34000  #1960 gaps/s 19.7M PPS 900K tests/s 0.23% t12 ft11 sp34000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 528 --crt crtwizz/crt-22m-0528s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 34000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 536 --crt crtwizz/crt-22m-0536s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 34000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 544 --crt crtwizz/crt-22m-0544s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 35000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 555 --crt crtwizz/crt-22m-0555s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 35000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 565 --crt crtwizz/crt-22m-0565s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 35000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 576 --crt crtwizz/crt-22m-0576s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 35000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 584 --crt crtwizz/crt-22m-0584s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 36000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 592 --crt crtwizz/crt-22m-0592s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 36000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 600 --crt crtwizz/crt-22m-0600s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 36000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 608 --crt crtwizz/crt-22m-0608s.txt --threads 12 --fermat-threads 11 --sieve-primes 37500
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 619 --crt crtwizz/crt-22m-0619s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 37500
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 629 --crt crtwizz/crt-22m-0629s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 37500
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 640 --crt crtwizz/crt-22m-0640s.txt --threads 12 --fermat-threads 11 --sieve-primes 42500
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 648 --crt crtwizz/crt-22m-0648s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 42500
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 656 --crt crtwizz/crt-22m-0656s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 42500
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 664 --crt crtwizz/crt-22m-0664s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 42500
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 672 --crt crtwizz/crt-22m-0672s.txt --threads 12 --fermat-threads 11 --sieve-primes 47000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 680 --crt crtwizz/crt-22m-0680s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 47000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 688 --crt crtwizz/crt-22m-0688s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 47000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 696 --crt crtwizz/crt-22m-0696s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 47000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 704 --crt crtwizz/crt-22m-0704s-wizz.txt --threads 12 --fermat-threads 11 --sieve-primes 50000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 715 --crt crtwizz/s715.txt --threads 12 --fermat-threads 11 --sieve-primes 50000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 725 --crt crtwizz/s725.txt --threads 12 --fermat-threads 11 --sieve-primes 50000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 736 --crt crtwizz/crt-22m-0736s.txt --threads 12 --fermat-threads 11 --sieve-primes 55000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 744 --crt crtwizz/s744.txt --threads 12 --fermat-threads 11 --sieve-primes 55000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 752 --crt crtwizz/s752.txt --threads 12 --fermat-threads 11 --sieve-primes 55000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 760 --crt crtwizz/s760.txt --threads 12 --fermat-threads 11 --sieve-primes 55000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 768 --crt crtwizz/crt-22m-0768s.txt --threads 12 --fermat-threads 11 --sieve-primes 55000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 779 --crt crtwizz/s779.txt --threads 12 --fermat-threads 11 --sieve-primes 55000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 789 --crt crtwizz/s789.txt --threads 12 --fermat-threads 11 --sieve-primes 55000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 800 --crt crtwizz/crt-22m-0800s.txt --threads 12 --fermat-threads 11 --sieve-primes 60000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 808 --crt crtwizz/s808.txt --threads 12 --fermat-threads 11 --sieve-primes 60000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 816 --crt crtwizz/s816.txt --threads 12 --fermat-threads 11 --sieve-primes 60000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 824 --crt crtwizz/s824.txt --threads 12 --fermat-threads 11 --sieve-primes 60000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 832 --crt crtwizz/crt-22m-0832s.txt --threads 12 --fermat-threads 11 --sieve-primes 65000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 840 --crt crtwizz/s840.txt --threads 12 --fermat-threads 11 --sieve-primes 65000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 848 --crt crtwizz/s848.txt --threads 12 --fermat-threads 11 --sieve-primes 65000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 856 --crt crtwizz/s856.txt --threads 12 --fermat-threads 11 --sieve-primes 65000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 864 --crt crtwizz/crt-22m-0864s.txt --threads 12 --fermat-threads 11 --sieve-primes 70000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 872 --crt crtwizz/s872.txt --threads 12 --fermat-threads 11 --sieve-primes 70000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 880 --crt crtwizz/s880.txt --threads 12 --fermat-threads 11 --sieve-primes 70000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 888 --crt crtwizz/s888.txt --threads 12 --fermat-threads 11 --sieve-primes 70000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 896 --crt crtwizz/crt-22m-0896s.txt --threads 12 --fermat-threads 11 --sieve-primes 75000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 907 --crt crtwizz/s907.txt --threads 12 --fermat-threads 11 --sieve-primes 75000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 917 --crt crtwizz/s917.txt --threads 12 --fermat-threads 11 --sieve-primes 75000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 928 --crt crtwizz/crt-22m-0928s.txt --threads 12 --fermat-threads 11 --sieve-primes 80000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 938 --crt crtwizz/s938.txt --threads 12 --fermat-threads 1 --sieve-primes 80000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 949 --crt crtwizz/s949.txt --threads 12 --fermat-threads 11 --sieve-primes 80000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 956 --crt crtwizz/s956.txt --threads 12 --fermat-threads 11 --sieve-primes 80000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 965 --crt crtwizz/s965.txt --threads 12 --fermat-threads 11 --sieve-primes 80000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 974 --crt crtwizz/s974.txt --threads 12 --fermat-threads 11 --sieve-primes 80000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 983 --crt crtwizz/s983.txt --threads 12 --fermat-threads 11 --sieve-primes 80000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 992 --crt crtwizz/crt-22m-0992s.txt --threads 12 --fermat-threads 11 --sieve-primes 85000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 1003 --crt crtwizz/s1003.txt --threads 12 --fermat-threads 11 --sieve-primes 85000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 1013 --crt crtwizz/s1013.txt --threads 12 --fermat-threads 11 --sieve-primes 85000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 1024 --crt crtwizz/crt-22m-1024s-pdazzl.txt --threads 12 --fermat-threads 11 --sieve-primes 90000  #350 gaps/s 21M PPS 155K tests/s 0.24% t12 ft11 sp90000

::pause


::2/2
:: School for more PPS and more % :
::
:: Instructions:
:: 1.1 - Set --fermat-threads = --threads minus four between shift 64 and shift 128.
:: 1.2 - Set --fermat-threads = --threads minus three between shift 128 and shift 512(?).
:: 1.3 - Set --fermat-threads = --threads minus two above shift 512(?).
:: 2 - Set --sieve-primes for an optimal value.
:: 3 - Miners should use a random/different shift when starting CRT miner, choose a non-overmined shift.
:: You can mine in --shift 510, using the crt file 'crt-22m-512s.txt'.
::
::
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 64 --crt crtwizz/crt-22m-0064s-wizz.txt --threads 12 --fermat-threads 8 --sieve-primes 4400  #32500 gaps/s 4M PPS 2.5M tests/s 0.045% t12 ft8 sp4400   ##t-4
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 70 --crt crtwizz/crt-22m-0070s-wizz.txt --threads 12 --fermat-threads 8 --sieve-primes 4500  #25400 gaps/s 3.9M PPS 2.5M tests/s 0.045% t12 ft8 sp4500
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 77 --crt crtwizz/crt-22m-0077s-wizz.txt --threads 12 --fermat-threads 8 --sieve-primes 4600
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 83 --crt crtwizz/crt-22m-0083s-wizz.txt --threads 12 --fermat-threads 8 --sieve-primes 4700
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 90 --crt crtwizz/crt-22m-0090s-wizz.txt --threads 12 --fermat-threads 8 --sieve-primes 4800
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 96 --crt crtwizz/crt-22m-0096s.txt --threads 12 --fermat-threads 8 --sieve-primes 4900
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 102 --crt crtwizz/crt-22m-0102s-wizz.txt --threads 12 --fermat-threads 8 --sieve-primes 5000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 109 --crt crtwizz/crt-22m-0109s-wizz.txt --threads 12 --fermat-threads 8 --sieve-primes 5000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 115 --crt crtwizz/crt-22m-0115s-wizz.txt --threads 12 --fermat-threads 8 --sieve-primes 5000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 122 --crt crtwizz/crt-22m-0122s-wizz.txt --threads 12 --fermat-threads 8 --sieve-primes 5000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 128 --crt crtwizz/crt-22m-0128s-benxy031.txt --threads 12 --fermat-threads 9 --sieve-primes 5000  #19700 gaps/s 8.9M PPS 4M tests/s 0.122% t12 ft9 sp4500   ##t-3
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 134 --crt crtwizz/crt-22m-0134s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 5000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 141 --crt crtwizz/crt-22m-0141s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 5000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 147 --crt crtwizz/crt-22m-0147s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 5000 
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 154 --crt crtwizz/crt-22m-0154s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 5000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 160 --crt crtwizz/crt-22m-0160s.txt --threads 12 --fermat-threads 9 --sieve-primes 5500
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 166 --crt crtwizz/crt-22m-0166s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 5500
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 173 --crt crtwizz/crt-22m-0173s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 6000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 179 --crt crtwizz/crt-22m-0179s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 6000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 186 --crt crtwizz/crt-22m-0186s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 6000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 192 --crt crtwizz/crt-22m-0192s.txt --threads 12 --fermat-threads 9 --sieve-primes 6000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 200 --crt crtwizz/crt-22m-0200s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 6000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 208 --crt crtwizz/crt-22m-0208s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 7000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 216 --crt crtwizz/crt-22m-0216s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 7000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 224 --crt crtwizz/crt-22m-0224s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 7000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 232 --crt crtwizz/crt-22m-0232s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 7000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 240 --crt crtwizz/crt-22m-0240s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 8000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 248 --crt crtwizz/crt-22m-0248s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 8000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 256 --crt crtwizz/crt-22m-0256s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 8000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 264 --crt crtwizz/crt-22m-0264s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 8000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 272 --crt crtwizz/crt-22m-0272s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 8000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 280 --crt crtwizz/crt-22m-0280s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 9000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 288 --crt crtwizz/crt-22m-0288s.txt --threads 12 --fermat-threads 9 --sieve-primes 9000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 296 --crt crtwizz/crt-22m-0296s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 9000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 304 --crt crtwizz/crt-22m-0304s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 9000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 312 --crt crtwizz/crt-22m-0312s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 9000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 320 --crt crtwizz/crt-22m-0320s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 10000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 326 --crt crtwizz/crt-22m-0326s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 10000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 333 --crt crtwizz/crt-22m-0333s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 10000  #3800 gaps/s 22M PPS 1.5M tests/s 0.25% t12 ft9 sp10000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 339 --crt crtwizz/crt-22m-0339s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 10000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 346 --crt crtwizz/crt-22m-0346s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 10000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 352 --crt crtwizz/crt-22m-0352s.txt --threads 12 --fermat-threads 9 --sieve-primes 11000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 362 --crt crtwizz/crt-22m-0362s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 11000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 373 --crt crtwizz/crt-22m-0373s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 11000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 384 --crt crtwizz/crt-22m-0384s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 11000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 392 --crt crtwizz/crt-22m-0392s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 11000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 400 --crt crtwizz/crt-22m-0400s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 12000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 408 --crt crtwizz/crt-22m-0408s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 12000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 415 --crt crtwizz/crt-22m-0416s-pdazzl.txt --threads 12 --fermat-threads 9 --sieve-primes 12000  #2830 gaps/s 27.7M PPS 1.2M tests/s 0.368% t12 ft9 sp 13000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 424 --crt crtwizz/crt-22m-0424s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 12000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 432 --crt crtwizz/crt-22m-0432s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 12000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 440 --crt crtwizz/crt-22m-0440s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 13000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 448 --crt crtwizz/crt-22m-0448s.txt --threads 12 --fermat-threads 9 --sieve-primes 13000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 456 --crt crtwizz/crt-22m-0456s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 13000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 464 --crt crtwizz/crt-22m-0464s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 13000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 472 --crt crtwizz/crt-22m-0472s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 14000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 480 --crt crtwizz/crt-22m-0480s-pdazzl.txt --threads 12 --fermat-threads 9 --sieve-primes 14000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 488 --crt crtwizz/crt-22m-0488s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 14000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 496 --crt crtwizz/crt-22m-0496s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 14000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 504 --crt crtwizz/crt-22m-0504s-wizz.txt --threads 12 --fermat-threads 9 --sieve-primes 15000  #1730 gaps/s 25.5M PPS 880K tests/s 0.29% t12 ft9 sp14000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 512 --crt crtwizz/crt-22m-0512s-pdazzl.txt --threads 12 --fermat-threads 10 --sieve-primes 15000  #1910 gaps/s 26.3M PPS 930K tests/s 0.30% t12 ft10 sp15000   ##t-2
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 520 --crt crtwizz/crt-22m-0520s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 16000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 528 --crt crtwizz/crt-22m-0528s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 16000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 536 --crt crtwizz/crt-22m-0536s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 16000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 544 --crt crtwizz/crt-22m-0544s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 17000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 555 --crt crtwizz/crt-22m-0555s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 17000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 565 --crt crtwizz/crt-22m-0565s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 17000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 576 --crt crtwizz/crt-22m-0576s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 18000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 584 --crt crtwizz/crt-22m-0584s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 18000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 592 --crt crtwizz/crt-22m-0592s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 18000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 600 --crt crtwizz/crt-22m-0600s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 18000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 608 --crt crtwizz/crt-22m-0608s.txt --threads 12 --fermat-threads 10 --sieve-primes 19000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 619 --crt crtwizz/crt-22m-0619s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 19000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 629 --crt crtwizz/crt-22m-0629s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 19000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 640 --crt crtwizz/crt-22m-0640s.txt --threads 12 --fermat-threads 10 --sieve-primes 21000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 648 --crt crtwizz/crt-22m-0648s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 21000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 656 --crt crtwizz/crt-22m-0656s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 21000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 664 --crt crtwizz/crt-22m-0664s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 21000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 672 --crt crtwizz/crt-22m-0672s.txt --threads 12 --fermat-threads 10 --sieve-primes 23000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 680 --crt crtwizz/crt-22m-0680s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 23000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 688 --crt crtwizz/crt-22m-0688s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 23000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 696 --crt crtwizz/crt-22m-0696s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 23000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 704 --crt crtwizz/crt-22m-0704s-wizz.txt --threads 12 --fermat-threads 10 --sieve-primes 25000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 715 --crt crtwizz/s715.txt --threads 12 --fermat-threads 10 --sieve-primes 25000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 725 --crt crtwizz/s725.txt --threads 12 --fermat-threads 10 --sieve-primes 25000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 736 --crt crtwizz/crt-22m-0736s.txt --threads 12 --fermat-threads 10 --sieve-primes 27000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 744 --crt crtwizz/s744.txt --threads 12 --fermat-threads 10 --sieve-primes 27000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 752 --crt crtwizz/s752.txt --threads 12 --fermat-threads 10 --sieve-primes 27000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 760 --crt crtwizz/s760.txt --threads 12 --fermat-threads 10 --sieve-primes 27000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 768 --crt crtwizz/crt-22m-0768s.txt --threads 12 --fermat-threads 10 --sieve-primes 27000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 779 --crt crtwizz/s779.txt --threads 12 --fermat-threads 10 --sieve-primes 27000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 789 --crt crtwizz/s789.txt --threads 12 --fermat-threads 10 --sieve-primes 27000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 800 --crt crtwizz/crt-22m-0800s.txt --threads 12 --fermat-threads 10 --sieve-primes 30000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 808 --crt crtwizz/s808.txt --threads 12 --fermat-threads 10 --sieve-primes 30000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 816 --crt crtwizz/s816.txt --threads 12 --fermat-threads 10 --sieve-primes 30000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 824 --crt crtwizz/s824.txt --threads 12 --fermat-threads 10 --sieve-primes 30000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 832 --crt crtwizz/crt-22m-0832s.txt --threads 12 --fermat-threads 10 --sieve-primes 32000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 840 --crt crtwizz/s840.txt --threads 12 --fermat-threads 10 --sieve-primes 32000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 848 --crt crtwizz/s848.txt --threads 12 --fermat-threads 10 --sieve-primes 32000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 856 --crt crtwizz/s856.txt --threads 12 --fermat-threads 10 --sieve-primes 32000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 864 --crt crtwizz/crt-22m-0864s.txt --threads 12 --fermat-threads 10 --sieve-primes 35000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 872 --crt crtwizz/s872.txt --threads 12 --fermat-threads 10 --sieve-primes 35000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 880 --crt crtwizz/s880.txt --threads 12 --fermat-threads 10 --sieve-primes 35000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 888 --crt crtwizz/s888.txt --threads 12 --fermat-threads 10 --sieve-primes 35000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 896 --crt crtwizz/crt-22m-0896s.txt --threads 12 --fermat-threads 10 --sieve-primes 38000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 907 --crt crtwizz/s907.txt --threads 12 --fermat-threads 10 --sieve-primes 38000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 917 --crt crtwizz/s917.txt --threads 12 --fermat-threads 10 --sieve-primes 38000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 928 --crt crtwizz/crt-22m-0928s.txt --threads 12 --fermat-threads 10 --sieve-primes 40000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 938 --crt crtwizz/s938.txt --threads 12 --fermat-threads 10 --sieve-primes 40000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 949 --crt crtwizz/s949.txt --threads 12 --fermat-threads 10 --sieve-primes 40000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 956 --crt crtwizz/s956.txt --threads 12 --fermat-threads 10 --sieve-primes 40000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 965 --crt crtwizz/s965.txt --threads 12 --fermat-threads 10 --sieve-primes 40000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 974 --crt crtwizz/s974.txt --threads 12 --fermat-threads 10 --sieve-primes 40000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 983 --crt crtwizz/s983.txt --threads 12 --fermat-threads 10 --sieve-primes 40000
:::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 992 --crt crtwizz/crt-22m-0992s.txt --threads 12 --fermat-threads 10 --sieve-primes 43000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 1003 --crt crtwizz/s1003.txt --threads 12 --fermat-threads 10 --sieve-primes 43000
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 1013 --crt crtwizz/s1013.txt --threads 12 --fermat-threads 10 --sieve-primes 43000
::::::::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x toto --shift 1024 --crt crtwizz/crt-22m-1024s-pdazzl.txt --threads 12 --fermat-threads 10 --sieve-primes 45000  #300 gaps/s 24M PPS 140K tests/s 0.285% t12 ft10 sp45000

::pause


::Legend:
:: Wizz settings (only -t 12 /16)
:::Default --sieve-primes value, for 4cores/8threads

::CRT using example files:
::
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 64 --crt crt/crt-22m-64s.txt --threads 12 --fermat-threads 9 --sieve-primes 7500  #ok max 37500 gaps/s 2.5M tests/s 0.03% t12 ft9 sp7500
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 96 --crt crt/crt-22m-96s.txt --threads 12 --fermat-threads 10 --sieve-primes 5000  #ok max 27000 gaps/s 3.2M tests/s 0.05% t12 ft10 sp 5000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 96 --crt crt/crt-22m-96s.txt --threads 7 --fermat-threads 1 --sieve-primes 150000  #ok max 3100 gaps/s 100K tests/s 0.005% t7 ft2 #Short gaplist with ft2
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 128 --crt crt/crt-22m-128s.txt --threads 12 --fermat-threads 10 --sieve-primes 7500  #ok max 22500 gaps/s 4.2M tests/s 0.052% t12 ft10 sp 7500
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 128 --crt crt/crt-22m-128s.txt --threads 7 --fermat-threads 2 --sieve-primes 140000  #ok max 3100 gaps/s 160K tests/s 0.012% t7 ft2 #Short gaplist with ft2
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 160 --crt crt/crt-22m-160s.txt --threads 12 --fermat-threads 11 --sieve-primes 5000  #ok max 16500 gaps/s 4M tests/s 0.09% t12 ft11 sp5000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 160 --crt crt/crt-22m-160s.txt --threads 7 --fermat-threads 2 --sieve-primes 140000  #ok max 2700 gaps/s 190K tests/s 0.020% t7 ft2
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 192 --crt crt/crt-22m-192s.txt --threads 12 --fermat-threads 11 --sieve-primes 6000  #ok max 14500 gaps/s 4M tests/s 0.09% t12 ft11 sp6000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 192 --crt crt/crt-22m-192s.txt --threads 7 --fermat-threads 3 --sieve-primes 130000  #ok max 2700 gaps/s 210K tests/s 0.022% t7 ft3 #Short gaplist with ft3
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 224 --crt crt/crt-22m-224s.txt --threads 12 --fermat-threads 11 --sieve-primes 8000  #ok max 10300 gaps/s 3M tests/s 0.1% t12 ft11 sp 8000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 224 --crt crt/crt-22m-224s.txt --threads 7 --fermat-threads 3 --sieve-primes 130000  #ok max 2400 gaps/s 250K tests/s 0.022% t7 ft3
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 256 --crt crt/crt-22m-256s.txt --threads 12 --fermat-threads 11 --sieve-primes 10000  #ok max 9100 gaps/s 3.3M tests/s 0.11% t12 ft11 sp10000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 256 --crt crt/crt-22m-256s.txt --threads 7 --fermat-threads 3 --sieve-primes 50000  #ok max 2050 gaps/s 260K tests/s 0.030% t7 ft3
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 288 --crt crt/crt-22m-288s.txt --threads 12 --fermat-threads 11 --sieve-primes 12500  #ok max 6800 gaps/s 2.6M tests/s 0.13% t12 ft11 sp12500
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 288 --crt crt/crt-22m-288s.txt --threads 7 --fermat-threads 4 --sieve-primes 130000  #ok max 2000 gaps/s 235K tests/s 0.030% t7 ft4 #Short gaplist with ft4
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 320 --crt crt/crt-22m-320s.txt --threads 12 --fermat-threads 11 --sieve-primes 15000  #ok max 6200 gaps/s 2.3M tests/s 0.15% t12 ft11 sp15000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 320 --crt crt/crt-22m-320s.txt --threads 7 --fermat-threads 4 --sieve-primes 120000  #ok max 1800 gaps/s 250K tests/s 0.045% t7 ft4
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 352 --crt crt/crt-22m-352s.txt --threads 12 --fermat-threads 11 --sieve-primes 5000  #sp5000 0.25% #ok max 4600 gaps/s 2M tests/s 0.15% t12 ft11 sp18000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 352 --crt crt/crt-22m-352s.txt --threads 7 --fermat-threads 4 --sieve-primes 120000  #ok max 1400 gaps/s 180K tests/s 0.055% t7 ft4
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 384 --crt crt/crt-22m-384s.txt --threads 12 --fermat-threads 11 --sieve-primes 20000  #ok max 4200 gaps/s 1.6M tests/s 0.14% t12 ft11 sp20000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 384 --crt crt/crt-22m-384s.txt --threads 7 --fermat-threads 4 --sieve-primes 120000  #ok max 1200 gaps/s 190K tests/s 0.055% t7 ft4
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 416 --crt crt/crt-22m-416s.txt --threads 12 --fermat-threads 11 --sieve-primes 22500  #ok max 3300 gaps/s 1.3M tests/s 0.15% t12 ft11 sp 22500
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 416 --crt crt/crt-22m-416s.txt --threads 7 --fermat-threads 5 --sieve-primes 120000  #ok max 1200 gaps/s 170K tests/s 0.055% t7 ft5
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 448 --crt crt/crt-22m-448s.txt --threads 12 --fermat-threads 11 --sieve-primes 26000  #ok max 3000 gaps/s 1.5M tests/s 0.16% t12 ft11 sp26000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 448 --crt crt/crt-22m-448s.txt --threads 7 --fermat-threads 5 --sieve-primes 120000  #ok max 1100 gaps/s 170K tests/s 0.070% t7 ft5
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 480 --crt crt/crt-22m-480s.txt --threads 12 --fermat-threads 11 --sieve-primes 30000  #ok max 2550 gaps/s 1.3M tests/s 0.17% t12 ft11 sp30000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 480 --crt crt/crt-22m-480s.txt --threads 7 --fermat-threads 5 --sieve-primes 120000  #ok max 880 gaps/s 130K tests/s 0.070% t7 ft5
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 512 --crt crt/crt-22m-512s.txt --threads 12 --fermat-threads 11 --sieve-primes 32000  #ok max 2300 gaps/s 1.1M tests/s 0.17% t12 ft11 sp32000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 512 --crt crt/crt-22m-512s.txt --threads 7 --fermat-threads 5 --sieve-primes 110000  #ok max 790 gaps/s 130K tests/s 0.080% t7 ft5
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 544 --crt crt/crt-22m-544s.txt --threads 12 --fermat-threads 11 --sieve-primes 34000  #ok max 1830 gaps/s 1M tests/s 0.15% t12 ft11 sp34000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 544 --crt crt/crt-22m-544s.txt --threads 7 --fermat-threads 6 --sieve-primes 110000  #ok max 770 gaps/s 110K tests/s 0.050% t7 ft6
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 576 --crt crt/crt-22m-576s.txt --threads 12 --fermat-threads 11 --sieve-primes 35000  #ok max 1700 gaps/s 750K tests/s 0.16% t12 ft11 sp35000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 576 --crt crt/crt-22m-576s.txt --threads 7 --fermat-threads 6 --sieve-primes 110000  #ok max 710 gaps/s 120K tests/s 0.055% t7 ft6
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 608 --crt crt/crt-22m-608s.txt --threads 12 --fermat-threads 11 --sieve-primes 37500  #ok max 1420 gaps/s 600K tests/s 0.21% t12 ft11 sp37500
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 608 --crt crt/crt-22m-608s.txt --threads 7 --fermat-threads 6 --sieve-primes 110000  #ok max 570 gaps/s 90K tests/s 0.060% t7 ft6
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 640 --crt crt/crt-22m-640s.txt --threads 12 --fermat-threads 11 --sieve-primes 42500  #ok max 1250 gaps/s 550K tests/s 0.18% t12 ft11 sp42500
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 640 --crt crt/crt-22m-640s.txt --threads 7 --fermat-threads 6 --sieve-primes 110000  #ok max 530 gaps/s 85K tests/s 0.060% t7 ft6
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 672 --crt crt/crt-22m-672s.txt --threads 12 --fermat-threads 11 --sieve-primes 47000  #ok max 1150 gaps/s 550K tests/s 0.19% t12 ft11 sp47000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 672 --crt crt/crt-22m-672s.txt --threads 7 --fermat-threads 6 --sieve-primes 110000  #ok max 430 gaps/s 65K tests/s 0.060% t7 ft6
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 704 --crt crt/crt-22m-704s.txt --threads 12 --fermat-threads 11 --sieve-primes 50000  #ok max 1000 gaps/s 450K tests/s 0.2% t12 ft11 sp50000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 704 --crt crt/crt-22m-704s.txt --threads 7 --fermat-threads 6 --sieve-primes 100000  #ok max 400 gaps/s 62K tests/s 0.065% t7 ft6
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 736 --crt crt/crt-22m-736s.txt --threads 12 --fermat-threads 11 --sieve-primes 55000  #ok max 860 gaps/s 450K tests/s 0.18% t12 ft11 sp50000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 736 --crt crt/crt-22m-736s.txt --threads 7 --fermat-threads 6 --sieve-primes 100000  #ok max 330 gaps/s 55K tests/s 0.065% t7 ft6
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 768 --crt crt/crt-22m-768s.txt --threads 12 --fermat-threads 11 --sieve-primes 55000  #ok max 800 gaps/s 400K tests/s 0.2% t12 ft10 sp55000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 768 --crt crt/crt-22m-768s.txt --threads 7 --fermat-threads 6 --sieve-primes 100000  #ok max 310 gaps/s 52K tests/s 0.075% t7 ft6
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 800 --crt crt/crt-22m-800s.txt --threads 12 --fermat-threads 11 --sieve-primes 60000  #ok max 700 gaps/s 300K tests/s 0.19% t12 ft11 sp60000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 800 --crt crt/crt-22m-800s.txt --threads 7 --fermat-threads 6 --sieve-primes 100000  #ok max 270 gaps/s 42K tests/s 0.065% t7 ft6
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 832 --crt crt/crt-22m-832s.txt --threads 12 --fermat-threads 11 --sieve-primes 65000  #ok max 630 gaps/s 300K tests/s 0.14% t12 ft11 sp65000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 832 --crt crt/crt-22m-832s.txt --threads 7 --fermat-threads 6 --sieve-primes 100000  #ok max 240 gaps/s 35K tests/s 0.065% t7 ft6
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 864 --crt crt/crt-22m-864s.txt --threads 12 --fermat-threads 11 --sieve-primes 70000  #ok max 560 gaps/s 300K tests/s 0.19% t12 ft11 sp70000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 864 --crt crt/crt-22m-864s.txt --threads 7 --fermat-threads 6 --sieve-primes 100000  #ok max 215 gaps/s 30K tests/s 0.075% t7 ft6
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 896 --crt crt/crt-22m-896s.txt --threads 12 --fermat-threads 11 --sieve-primes 75000  #ok max 530 gaps/s 250K tests/s 0.17% t12 ft11 sp75000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 896 --crt crt/crt-22m-896s.txt --threads 7 --fermat-threads 6 --sieve-primes 100000  #ok max 200 gaps/s 30K tests/s 0.085% t7 ft6
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 928 --crt crt/crt-22m-928s.txt --threads 12 --fermat-threads 11 --sieve-primes 80000  #ok max 450 gaps/s 200K tests/s 0.15% t12 ft11 sp80000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 928 --crt crt/crt-22m-928s.txt --threads 7 --fermat-threads 6 --sieve-primes 90000   #ok max 180 gaps/s 25K tests/s 0.070% t7 ft6
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 992 --crt crt/crt-22m-992s.txt --threads 12 --fermat-threads 11 --sieve-primes 85000  #ok max 370 gaps/s 150K tests/s 0.16% t12 ft11 sp85000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 992 --crt crt/crt-22m-992s.txt --threads 7 --fermat-threads 6 --sieve-primes 90000   #ok max 140 gaps/s 20K tests/s 0.065% t7 ft6
::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 1024 --crt crt/crt-22m-1024s.txt --threads 12 --fermat-threads 11 --sieve-primes 90000  #ok max 340 gaps/s 135K tests/s 0.14% t12 ft11 sp90000
:::gapminer-cpu.exe -o http://127.0.0.1 -p 31397 -u user -x pwd --shift 1024 --crt crt/crt-22m-1024s.txt --threads 7 --fermat-threads 6 --sieve-primes 90000  #ok max 125 gaps/s 20K tests/s 0.050% t7 ft6

::pause
