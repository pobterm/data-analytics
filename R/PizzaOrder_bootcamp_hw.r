#pizza order

pizza_order <- function() {

df_mn <- data.frame(
menu_id = c(1:5),
menu_name = c("Hawaiian","Salmon","Pama","Cheese","Seafood"),
price = c(250, 400, 350, 300,380)
)

#Greeting
print("Welcome to Pizza Restaurant")
print(df_mn)
flush.console()
customer_action = readline("How can i help you? (Table booking (press 1) or Delivery order (press 2))")

#Table Booking

if (customer_action == 1) {
  flush.console()
  customer_name = readline("Your name: ")
  booking_date = readline("Date & Time: ")
  num_seat = readline("Number of seat: ")
  print("Thank you for booking with us")
  print("***Your booking details*** ")
  print(paste("Name: ", customer_name))
  print(paste("Booking Date: ", booking_date))
  print(paste("No. of seat", num_seat))

#Pizza Order
} else if (customer_action == 2) {
  total_bill <-0
  order_no <- 0
  order_id <- 8
  customer_name2 = readline("Your name:")
  customer_phone = readline("Phone number:")

    while(order_id != 10){
      flush.console()
      order_id = as.integer(readline("Please choose your order from menu_id (1-5) or press 10 to check bill)"))
      #order
      if(toupper(order_id) != "10"){
      flush.console()
      order_quan = as.integer(readline("How many you want?"))
      order_no = order_no + 1
      order_menu <- df_mn$menu_name[order_id]
      order_bill = df_mn[order_id,3]*order_quan
      total_bill = total_bill + order_bill
      print(paste(order_no, ":", order_menu, order_quan, "set, ", order_bill, "Baht"))
      }
      #check bill
      else if (order_id == 10) {
      print("***Thank you for your order*** ")
      print(paste("Your total bill amount = ", total_bill, "Baht"))
      print("Your order will be delivered soon. Enjoy your meal !!")
      break }
     }
}
}

pizza_order ()
