/************************inserting into Position**************************************/
use FoodTrucks1
GO

INSERT INTO tblPosition (PositionName, PositionDescription) 
VALUES 
('Manager','Runs day-to-day of truck'),
('Intern','Part-time team member'),
('Cashier','Handles transactions with customers'),
('Cook','Makes orders'),
('Bookkeeper','Manages all payments'),
('Promoter','Encourages people to eat at truck')


GO

INSERT INTO tblCompany (CompanyName, CompanyDescription)
VALUES
('Timmy and Taco','Mexican food'),
('Grilled Cheeses','Hot food with cheese'),
('India','Authentic Indian food'),
('Vegan Heaven','All vegan menu'),
('Olive You','Italian'),
('BYO','Build your own food'),
('BBQueue','Southern cuisine'),
('Corn Stalkoverflow','Make fun corn here'),
('Short Stackopancakes','Breakfast foods'),
('iSchream','Ice cream and gelato'),
('Cotton Candy Cloud','Desserts'),
('Lez Talk-o bout IT','Mexican food'),
('PC&J','Sandwiches'),
('Mac&cheesy','All kinds of macaroni'),
('4K Cheese Pizza','Fresh pizza'),
('Mango Mongo','Smoothie bar'),
('Digital Seafood','Fish and seafood'),
('Android Oreo','Desserts')


GO