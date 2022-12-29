import gmpy2
import random
import time
import math
import argparse
from concurrent.futures import ProcessPoolExecutor
import signal
import sys
import queue


parser = argparse.ArgumentParser()
parser.add_argument("--meritmin", type=float, default=5.0, help="Le merit minimum")
parser.add_argument("--digits", type=int, default=87, help="Le nombre de digits du nombre premier de départ")
parser.add_argument("--threads", type=int, default=4, help="Le nombre de threads à utiliser")
args = parser.parse_args()
threads = args.threads
digits = args.digits
merite_minimum = args.meritmin


# Fonction pour vérifier si un nombre est premier
def est_premier(n):
    return gmpy2.is_prime(n)

# Fonction pour trouver le prochain nombre premier
def prochain_premier(n):
    return gmpy2.next_prime(n)

# Fonction pour calculer le mérite d'un prime gap
def calculer_merite(gap, premier):
    return gap / math.log(premier)

def boucle(merite_minimum: float, digits: int):
    compteur_premiers = 0
    compteur_gaps = 0
    gap_maximum = 2000
    merite_maximum = merite_minimum
    start_time = time.time()
    timer = time.perf_counter()
    
    # Boucle principale
    while True:
        # Génération d'un nombre premier aléatoire de 87 digits
        premier = random.randint(10**digits, 10**(digits+1)-1)
        if est_premier(premier):
            compteur_premiers += 1
        else:
            premier = prochain_premier(premier)
            compteur_premiers += 1

        # Trouver le prochain nombre premier en utilisant l'hybrid sieving
        deuxieme_premier = prochain_premier(premier + 1)
        compteur_premiers += 1

        # Calculer le gap et le mérite
        gap = deuxieme_premier - premier
        merite = calculer_merite(gap, premier)
        compteur_gaps += 1
        merite_maximum = round(merite_maximum, 6)

        # Mise à jour des valeurs maximum si nécessaire
        if gap > gap_maximum:
            gap_maximum = gap
        if merite > merite_maximum or merite >= merite_minimum:
            merite_maximum = merite
            print("----------New Max Merit----------")
            print("Gap:", gap, "Mérite:", merite)
            print("GapStart:", premier)
            print("GapEnd:", deuxieme_premier)
        current_time = time.time()    
        if current_time - start_time >= 1:
                elapsed_time = time.perf_counter() - timer
                minutes, seconds = divmod(elapsed_time, 60)
                print(f"\rRunning {minutes:.0f}min {seconds:.0f}sec -{threads}t- MinMerit: {merite_minimum} ; Gaps/s: {compteur_gaps*threads} ; Primes/s: {compteur_premiers*threads} ; Max gap: {gap_maximum} ; Max merit: {merite_maximum}", end='\r', flush=True)
                compteur_premiers = 0
                compteur_gaps = 0
                start_time = current_time
                
    return gap, gap_maximum, merite, merite_maximum, premier, deuxieme_premier 

def exit_gracefully(signum, frame):
    sys.exit(0)
signal.signal(signal.SIGINT, exit_gracefully)

def main():
    max_workers = 0
    processes = []
    print(f"{threads} threads used")
    with ProcessPoolExecutor(max_workers=threads) as executor:
        for i in range(threads):
            executor.submit(boucle, merite_minimum, digits)
    for p in processes:
        p.join()

if __name__ == "__main__":
    main()
