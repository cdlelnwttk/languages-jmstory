       IDENTIFICATION DIVISION.
       PROGRAM-ID. BankingSystem.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 USER-CHOICE        PIC 9(1).
       01 ACCOUNT-BALANCE    PIC 9(6)V99 VALUE 1000.00.
       01 DEPOSIT-AMOUNT     PIC 9(6)V99 VALUE 0.00.
       01 WITHDRAW-AMOUNT    PIC 9(6)V99 VALUE 0.00.
       01 DUMMY              PIC X(1).

       PROCEDURE DIVISION.
       MAIN-PROCESS.
           DISPLAY "Welcome to the Basic Banking System"
           DISPLAY "===================================="
           DISPLAY "Your starting balance is: $1000.00"
           DISPLAY "Please select an option:"
           DISPLAY "1. Deposit Money"
           DISPLAY "2. Withdraw Money"
           DISPLAY "3. Check Balance"
           DISPLAY "4. Exit"
           ACCEPT USER-CHOICE

           EVALUATE USER-CHOICE
               WHEN 1
                   PERFORM DEPOSIT
               WHEN 2
                   PERFORM WITHDRAW
               WHEN 3
                   PERFORM CHECK-BALANCE
               WHEN 4
                   DISPLAY "Exiting the system. Goodbye!"
                   STOP RUN
               WHEN OTHER
                   DISPLAY "Invalid option. Please try again."
                   PERFORM MAIN-PROCESS
           END-EVALUATE.

       DEPOSIT.
           DISPLAY "Enter deposit amount: "
           ACCEPT DEPOSIT-AMOUNT
           ADD DEPOSIT-AMOUNT TO ACCOUNT-BALANCE
           DISPLAY "Deposit successful!"
           DISPLAY "Updated Balance: " ACCOUNT-BALANCE
           DISPLAY "Press Enter to return to the main menu..."
           ACCEPT DUMMY 
           PERFORM MAIN-PROCESS.

       WITHDRAW.
           DISPLAY "Enter withdrawal amount: "
           ACCEPT WITHDRAW-AMOUNT
           IF WITHDRAW-AMOUNT > ACCOUNT-BALANCE
               DISPLAY "Insufficient funds. Withdrawal denied."
           ELSE
               SUBTRACT WITHDRAW-AMOUNT FROM ACCOUNT-BALANCE
               DISPLAY "Withdrawal successful!"
               DISPLAY "Updated Balance: " ACCOUNT-BALANCE
           END-IF
           DISPLAY "Press Enter to return to the main menu..."
           ACCEPT DUMMY 
           PERFORM MAIN-PROCESS.

       CHECK-BALANCE.
           DISPLAY "===================================="
           DISPLAY "Current Balance: " ACCOUNT-BALANCE
           DISPLAY "===================================="
           DISPLAY "Press Enter to return to the main menu..."
           ACCEPT DUMMY
           PERFORM MAIN-PROCESS.






