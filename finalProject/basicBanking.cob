       IDENTIFICATION DIVISION.
       PROGRAM-ID. BankingSystem.
       AUTHOR. Jessica Story.
       DATE-WRITTEN. 12-09-2024.
       DATE-COMPILED. 12-09-2024.
       SECURITY. None.
       REMARKS. This is a basic program.

       ENVIRONMENT DIVISION.
              CONFIGURATION SECTION.
                     SOURCE-COMPUTER. MICROSOFT-WINDOWS.
                     OBJECT-COMPUTER. MICROSOFT-WINDOWS.
              INPUT-OUTPUT SECTION.
                  FILE-CONTROL.
                      SELECT TRANSACTION-FILE
                          ASSIGN TO 'TRANSACTIONS.TXT'
                          ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD TRANSACTION-FILE.
       01 TRANSACTION-RECORD.
           05 TRANSACTION-TYPE    PIC X(10).
           05 TRANSACTION-AMOUNT  PIC 9(6)V99.
           05 TRANSACTION-DATE    PIC X(10).

       WORKING-STORAGE SECTION.
       01 USER-CHOICE        PIC 9(1).
       01 ACCOUNT-BALANCE    PIC 9(6)V99 VALUE 1000.00.
       01 DEPOSIT-AMOUNT     PIC 9(6)V99 VALUE 0.00.
       01 WITHDRAW-AMOUNT    PIC 9(6)V99 VALUE 0.00.
       01 DUMMY              PIC X(1).
       01 EOF-FLAG           PIC X VALUE 'N'.

       LOCAL-STORAGE SECTION.
       LINKAGE SECTION.

       
       PROCEDURE DIVISION.
       MAIN-PROCESS.
           DISPLAY "Welcome to the Basic Banking System"
           DISPLAY "===================================="
           DISPLAY "Your starting balance is: $1000.00"
           DISPLAY "Please select an option:"
           DISPLAY "1. Deposit Money"
           DISPLAY "2. Withdraw Money"
           DISPLAY "3. Check Balance"
           DISPLAY "4. View Previous Transactions"
           DISPLAY "5. Set Account Balance"
           DISPLAY "6. Exit"
           ACCEPT USER-CHOICE

           EVALUATE USER-CHOICE
               WHEN 1
                   PERFORM DEPOSIT
               WHEN 2
                   PERFORM WITHDRAW
               WHEN 3
                   PERFORM CHECK-BALANCE
               WHEN 4
                   PERFORM VIEW-TRANSACTIONS
               WHEN 5
                   PERFORM SET-ACCOUNT-BALANCE
               WHEN 6
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

       VIEW-TRANSACTIONS.
           OPEN INPUT TRANSACTION-FILE
           PERFORM READ-TRANSACTIONS UNTIL EOF-FLAG = 'Y'
           CLOSE TRANSACTION-FILE
           DISPLAY "Press Enter to return to the main menu..."
           ACCEPT DUMMY
           PERFORM MAIN-PROCESS.

       READ-TRANSACTIONS.
           READ TRANSACTION-FILE INTO TRANSACTION-RECORD
               AT END
                   MOVE 'Y' TO EOF-FLAG
               NOT AT END
                   DISPLAY "Transaction Type: " TRANSACTION-TYPE
                   DISPLAY "Amount: " TRANSACTION-AMOUNT
                   DISPLAY "Date: " TRANSACTION-DATE
           END-READ.

       SET-ACCOUNT-BALANCE.
           DISPLAY "Enter a new account balance: "
           ACCEPT ACCOUNT-BALANCE
           DISPLAY "Account balance successfully updated!"
           DISPLAY "Updated Balance: " ACCOUNT-BALANCE
           DISPLAY "Press Enter to return to the main menu..."
           ACCEPT DUMMY
           PERFORM MAIN-PROCESS.








