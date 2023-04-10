
import mysql.connector

mydb = mysql.connector.connect(
	host = "localhost",
	user = "root",
	password = "root@123",
	database = "pharmacy"
)
cursor = mydb.cursor()
def add_medicine():
	print('---------------------------------------------')
	print("Enter Medicine Details            ")
	print('---------------------------------------------')
	med_name = input("Enter Medicine Name              \n")
	print('---------------------------------------------')
	brand_name = input("Enter Manufacturer Name              \n")
	print('---------------------------------------------')
	med_id = input("Enter Manufacturer Name              \n")
	print('---------------------------------------------')
	med_price = input("Enter Price                 \n")
	print('---------------------------------------------')
	med_cost = input("Enter Cost                 \n")
	print('---------------------------------------------')
	exp_date = input("Enter Expiry Date                 \n")
 
	sql_statement = "INSERT INTO MEDICINE (Name,Brand,Medicine_id,Price,Cost,Exp_Date) values(%s,%s,%s,%s,%s,%s)"
	values = (med_name,brand_name,med_id,med_price,med_cost,exp_date)
  
# Execute will help to insert a single row of data
	cursor.execute(sql_statement,values)
  
# To save the data into the database under the particular table
	cursor.commit()

def employee_dashboard():
    m_menu_choice=0
    while(m_menu_choice!=4):
        print('---------------------------------------------')
        print("|Enter 1 to add medicine                    |")
        print('---------------------------------------------')
        print('|Enter 2 to search medicine                 |')
        print('---------------------------------------------')
        print('|Enter 3 to update medicine info            |')
        print('---------------------------------------------') 
        print('|Enter 4 to go back to Main Menu            |')
        print('---------------------------------------------')
        m_menu_choice=int(input("Enter Your Choice!\n"))
        if(m_menu_choice==1):
            add_medicine()
    #    elif(m_menu_choice==2):
    #        search_medicine()
    #    elif(m_menu_choice==3):
    #        update_medicine()
    #    elif(m_menu_choice==4):
    #        break
        else:
            print("Invalid Input! Try Again!\n") 
            
def employee_login():
	print('---------------------------------------------')
	print("Enter Login Credentials            ")
	print('---------------------------------------------')
	emp_name = input("Enter Employee Name              \n")
	print('---------------------------------------------')
	id = input("Enter Employee ID                 \n")

	sql_statement = "SELECT name,Employee_id FROM EMPLOYEE WHERE name = %s and employee_id = %s" 
	values = (emp_name,id) 
 
	cursor.execute(sql_statement,values) 
 
	c=0;
	for x in cursor:
		c=1; 
		
	if c==1:
		print('---------------------------------------------')
		print("******** Employee Login Successful! *********")
		print('---------------------------------------------')
		employee_dashboard()

	elif c==0:
		print('---------------------------------------------')
		print('|Enter 1 to Try Again             |')
		print('---------------------------------------------')
		print('|Enter 2 to Register New Employee             |')
		print('---------------------------------------------')
		print('|Enter 3 to Exit                  |')
		print('---------------------------------------------') 
		choice = input("Enter your choice\n")
		if choice == '1':
			employee_login()
   
employee_login() 


            
