#1-Rock! Paper! Scissors!

play_rockpaperscissors <- function() {

#greeting
 print("Welcome to Rock! Paper! Scissors!")
 print("Game Rules: choose one of the folling choices")
 print("R = Rock ✊, S = Scissors ✌, P = Paper 🖐")

 player_name = readline("Your name: ")
 Hello = paste("Hello", player_name)


#variables
player_score <- 0
com_score <- 0
round <- 0
hands <- c("R","S","P")

while(round < 3) {
  flush.console()
  com_shoot <- sample(hands,1)
  player_shoot <- readline("Shoot? (R,P,S or Q to quit the game?)")

#Draw
if(toupper(player_shoot) == toupper(com_shoot)){
  round = round +1
  print(paste("Com: ",com_shoot))
  print(paste("Round",round, "Result: Draw"))
  print(paste("Your score: ", player_score, "|| Computor score: ", com_score))

#Player Win
} else if ((player_shoot == "R" & com_shoot == "S") |
           (player_shoot == "S" & com_shoot == "P") |
           (player_shoot == "P" & com_shoot == "R")) {
  round = round +1
  print(paste("Com: ",com_shoot))
  print(paste("Round",round, "Result: You Win!"))
  player_score = player_score +1
  print(paste("Your score: ", player_score, "|| Computor score: ", com_score))

#Player Loss
} else if ((player_shoot == "R" & com_shoot == "P") |
           (player_shoot == "S" & com_shoot == "R") |
           (player_shoot == "P" & com_shoot == "S")) {
  round = round +1
  print(paste("Com: ",com_shoot))
  print(paste("Round",round, "Result: You Lose!"))
  com_score = com_score +1
  print(paste("Your score: ", player_score, "|| Computor score: ", com_score))

#Quit
} else if (toupper(player_shoot) == "Q"){
 print ("Bye")
  break }
}

#end while loop

print("***End Game***")
print(paste("Your score: ", player_score, "|| Computor score: ", com_score))
}
