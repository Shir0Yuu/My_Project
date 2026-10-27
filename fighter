import random
import time
#รับ input 2 name character
P1 = input("Enter name of character 1 : ")
P2 = input("Enter name of character 2 : ")

#รับ input HP of 2 character
Hp1 = int(input("Enter HP of character 1 : "))
Hp2 = int(input("Enter HP of character 2 : "))
#start phase
print("Game Start")
time.sleep(1)
print("Round 1")
time.sleep(2)
print("Fight!!")
time.sleep(1)
round = random.randint(1,2)
print(f"Player {round} first . . .")

#กำหนดเงื่อนไขจบเกม
Endgame = False

##ส่วน while loop น่าจะใช้ในโปรเจกค์
while Endgame == False :
    #สุ่มค่า ATK and DEF
    Atk1 = random.randint(0,400)
    Def1 = random.randint(0,350)
    Atk2 = random.randint(0,400)
    Def2 = random.randint(0,350)

    if round == 1 : #check turn
        print("Player 1 Attacking . . .")
        
        #calculater lelf HP
        Damage1 = Atk1-Def2
        if Damage1 <= 0 :
            Damage1 = 0
        Hp2 = Hp2 - Damage1
        print(f"{P1} Attack {P2} {Damage1} damage")
        print(f"{P1} HP = {Hp1} \n{P2} HP = {Hp2}")
        time.sleep(1)
        
    elif round == 2 : #check turn
        print("Player 2 Attacking . . .")
        
        #calculater lelf HP
        Damage2 = Atk2-Def1
        if Damage2 <= 0 :
            Damage2 = 0
        Hp1 = Hp1 - Damage2
        print(f"{P2} Attack {P1} {Damage2} damage")
        print(f"{P1} HP = {Hp1} \n{P2} HP = {Hp2}")
        time.sleep(1)
        
    #check GameEnd
    if Hp1 <= 0 :
        Endgame = True
        print (f"{P2} win!!!")
    elif Hp2 <= 0 :
        Endgame = True
        print(f"{P1} win!!!")
        
    #change turn
    round = random.randint(1,2)
