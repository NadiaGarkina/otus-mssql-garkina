--- Заполняем таблицы фейковыми данными (https://www.mockaroo.com/)
--- Чтобы внешние ключи не мешали заполнению данными их отключаем
--- 1.Заполняем таблицу [Credits]
USE Bank_Credits_new;  
GO  
ALTER TABLE [Credits] 
NOCHECK CONSTRAINT FK_Credits_Client_ID;  
GO 
GO  
ALTER TABLE [Credits]  
NOCHECK CONSTRAINT FK_Credits_Product_ID;
GO  

SET IDENTITY_INSERT  [Credits]  ON

insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (1, '10/22/2023', 1, '4/1/2024', '6/13/2023', 37, '3583757956026565', '$8.16', 1);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (2, '11/10/2023', 2, '2/5/2024', '4/12/2024', 86, '6304223661807998', '$2.94', 2);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (3, '2/23/2024', 3, '2/23/2024', '11/7/2023', 93, '4175004429332854', '$5.39', 3);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (4, '2/5/2024', 4, '3/1/2024', '8/1/2023', 36, '6767899446369808', '$1.79', 4);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (5, '6/30/2023', 5, '4/16/2024', '3/9/2024', 43, '6759897482850095', '$2.90', 5);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (6, '2/25/2024', 6, '6/27/2023', '8/27/2023', 46, '3548139916925331', '$0.94', 6);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (7, '7/10/2023', 7, '10/4/2023', '6/16/2023', 90, '3545330717668799', '$2.13', 7);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (8, '6/29/2023', 8, '5/3/2023', '6/8/2023', 1, '3536494011634377', '$3.16', 8);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (9, '4/9/2024', 9, '10/24/2023', '7/6/2023', 93, '3578568826242150', '$6.73', 9);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (10, '7/29/2023', 10, '8/11/2023', '6/1/2023', 19, '30120852891019', '$4.75', 10);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (11, '3/30/2024', 11, '9/11/2023', '6/12/2023', 75, '3579769953072167', '$1.80', 11);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (12, '7/12/2023', 12, '8/21/2023', '8/22/2023', 29, '3581852941552197', '$3.68', 12);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (13, '10/30/2023', 13, '1/15/2024', '2/9/2024', 93, '3543185501894338', '$3.50', 13);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (14, '10/12/2023', 14, '1/6/2024', '4/12/2024', 97, '3582664567716272', '$2.01', 14);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (15, '3/23/2024', 15, '12/5/2023', '5/13/2023', 64, '5100142867450031', '$2.81', 15);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (16, '5/11/2023', 16, '9/5/2023', '4/14/2024', 3, '3529223804617193', '$0.88', 16);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (17, '10/21/2023', 17, '9/1/2023', '5/3/2023', 2, '201600174406714', '$7.85', 17);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (18, '9/6/2023', 18, '4/6/2024', '3/29/2024', 21, '6372423891617467', '$5.53', 18);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (19, '12/25/2023', 19, '8/2/2023', '7/3/2023', 6, '3529107867753377', '$0.53', 19);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (20, '11/27/2023', 20, '6/24/2023', '1/25/2024', 91, '3531354181872303', '$3.86', 20);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (21, '10/30/2023', 21, '2/5/2024', '11/12/2023', 74, '3541500147633985', '$5.55', 21);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (22, '7/26/2023', 22, '9/9/2023', '7/28/2023', 5, '201500076406020', '$3.73', 22);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (23, '4/21/2023', 23, '4/29/2023', '2/29/2024', 48, '3531934255326821', '$0.65', 23);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (24, '9/10/2023', 24, '5/8/2023', '9/16/2023', 49, '3555184694994778', '$2.91', 24);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (25, '1/19/2024', 25, '3/15/2024', '8/12/2023', 61, '3537882175620993', '$7.65', 25);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (26, '3/31/2024', 26, '8/29/2023', '7/7/2023', 97, '3537396876664101', '$2.09', 26);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (27, '11/8/2023', 27, '9/19/2023', '9/20/2023', 23, '3539533640353771', '$3.77', 27);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (28, '7/2/2023', 28, '1/22/2024', '5/31/2023', 28, '3561099555838033', '$6.80', 28);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (29, '1/11/2024', 29, '3/5/2024', '11/18/2023', 17, '490376354587230970', '$3.36', 29);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (30, '7/15/2023', 30, '7/19/2023', '11/21/2023', 54, '3562209663153121', '$5.56', 30);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (31, '1/10/2024', 31, '4/22/2023', '11/13/2023', 100, '3557272198426203', '$9.38', 31);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (32, '8/28/2023', 32, '2/24/2024', '8/22/2023', 46, '30538615864462', '$2.20', 32);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (33, '9/4/2023', 33, '3/29/2024', '7/6/2023', 96, '6706893407053436948', '$8.58', 33);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (34, '2/27/2024', 34, '8/8/2023', '8/22/2023', 31, '3554444522773450', '$6.93', 34);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (35, '4/13/2024', 35, '11/27/2023', '9/27/2023', 60, '3562020944316118', '$6.57', 35);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (36, '12/7/2023', 36, '10/26/2023', '1/16/2024', 90, '374283118882380', '$5.80', 36);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (37, '9/16/2023', 37, '7/1/2023', '1/27/2024', 30, '3535199960021838', '$7.86', 37);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (38, '7/12/2023', 38, '10/23/2023', '4/26/2023', 87, '4913185184384995', '$5.56', 38);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (39, '2/14/2024', 39, '3/27/2024', '4/26/2023', 56, '201486692955295', '$6.61', 39);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (40, '6/29/2023', 40, '4/10/2024', '7/16/2023', 44, '3558917193263220', '$3.81', 40);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (41, '12/1/2023', 41, '3/1/2024', '9/20/2023', 17, '56022348760654383', '$2.57', 41);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (42, '1/5/2024', 42, '12/3/2023', '10/3/2023', 67, '3555167642092258', '$3.32', 42);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (43, '1/8/2024', 43, '6/29/2023', '6/1/2023', 7, '201452493365191', '$1.56', 43);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (44, '6/10/2023', 44, '10/9/2023', '10/4/2023', 30, '5100171198342740', '$6.13', 44);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (45, '1/24/2024', 45, '11/9/2023', '3/15/2024', 57, '6304892189080955', '$3.82', 45);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (46, '2/22/2024', 46, '2/7/2024', '7/25/2023', 77, '3568280854350432', '$5.49', 46);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (47, '3/14/2024', 47, '8/24/2023', '6/4/2023', 57, '6759896134463286491', '$0.85', 47);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (48, '7/22/2023', 48, '6/23/2023', '8/25/2023', 47, '5018669757990669', '$0.22', 48);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (49, '10/27/2023', 49, '6/5/2023', '9/3/2023', 41, '201906529555059', '$7.24', 49);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (50, '10/1/2023', 50, '3/1/2024', '7/10/2023', 100, '6391115447622317', '$4.08', 50);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (51, '7/20/2023', 51, '9/28/2023', '4/29/2023', 7, '3530234193898515', '$3.04', 51);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (52, '12/16/2023', 52, '12/2/2023', '10/10/2023', 56, '3573873706719151', '$6.45', 52);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (53, '1/23/2024', 53, '2/28/2024', '10/24/2023', 65, '201570210251640', '$5.66', 53);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (54, '12/10/2023', 54, '5/22/2023', '7/7/2023', 94, '201903615737212', '$0.68', 54);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (55, '6/10/2023', 55, '4/22/2023', '12/1/2023', 32, '3574588815669894', '$9.39', 55);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (56, '12/13/2023', 56, '3/23/2024', '11/24/2023', 11, '490546430126628513', '$9.88', 56);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (57, '1/25/2024', 57, '9/4/2023', '2/13/2024', 40, '4917859100349169', '$2.52', 57);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (58, '11/23/2023', 58, '3/22/2024', '4/6/2024', 42, '5108751095458590', '$0.14', 58);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (59, '12/13/2023', 59, '12/28/2023', '7/27/2023', 47, '4041375502410441', '$1.78', 59);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (60, '6/11/2023', 60, '6/20/2023', '12/2/2023', 97, '3584821169036685', '$6.41', 60);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (61, '12/27/2023', 61, '5/25/2023', '4/14/2024', 15, '560222109302864214', '$0.01', 61);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (62, '2/16/2024', 62, '8/17/2023', '1/8/2024', 57, '3529041352187280', '$6.33', 62);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (63, '9/19/2023', 63, '7/21/2023', '7/26/2023', 2, '201658601940119', '$1.12', 63);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (64, '11/6/2023', 64, '9/20/2023', '5/13/2023', 31, '4175001186874623', '$7.59', 64);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (65, '3/19/2024', 65, '12/5/2023', '10/19/2023', 75, '3543853844931113', '$2.64', 65);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (66, '11/28/2023', 66, '2/11/2024', '4/9/2024', 13, '3568023099459117', '$6.40', 66);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (67, '9/13/2023', 67, '12/21/2023', '7/31/2023', 99, '4905475185221068', '$1.13', 67);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (68, '2/11/2024', 68, '11/22/2023', '5/17/2023', 46, '4903629403159806221', '$4.44', 68);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (69, '11/3/2023', 69, '4/18/2023', '7/20/2023', 70, '3553887737091608', '$3.34', 69);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (70, '5/7/2023', 70, '11/21/2023', '12/21/2023', 67, '3539108415896187', '$9.98', 70);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (71, '4/15/2024', 71, '6/29/2023', '1/24/2024', 44, '4903314379525251', '$6.76', 71);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (72, '10/15/2023', 72, '9/23/2023', '7/17/2023', 54, '3564089583504738', '$4.69', 72);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (73, '12/28/2023', 73, '9/27/2023', '4/30/2023', 8, '5418705764561295', '$5.19', 73);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (74, '8/16/2023', 74, '9/2/2023', '1/18/2024', 5, '30370753039081', '$0.75', 74);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (75, '6/4/2023', 75, '1/28/2024', '9/28/2023', 10, '4026862778344866', '$8.84', 75);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (76, '2/23/2024', 76, '7/26/2023', '8/31/2023', 85, '3563823179991201', '$3.80', 76);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (77, '6/14/2023', 77, '8/12/2023', '9/16/2023', 51, '6334927796374773', '$5.26', 77);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (78, '3/25/2024', 78, '6/4/2023', '9/11/2023', 80, '5602258951854487700', '$8.06', 78);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (79, '6/1/2023', 79, '7/14/2023', '12/11/2023', 35, '6334558361015879', '$9.48', 79);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (80, '3/10/2024', 80, '3/19/2024', '9/19/2023', 23, '5038964537780785697', '$7.62', 80);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (81, '4/27/2023', 81, '5/16/2023', '12/7/2023', 6, '4017956458318389', '$5.10', 81);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (82, '9/9/2023', 82, '5/6/2023', '2/3/2024', 27, '3551669698583563', '$8.99', 82);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (83, '2/18/2024', 83, '8/9/2023', '12/22/2023', 31, '6763524462084420', '$8.03', 83);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (84, '12/28/2023', 84, '6/2/2023', '5/5/2023', 20, '4911701177529629091', '$7.92', 84);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (85, '11/14/2023', 85, '2/6/2024', '12/4/2023', 98, '201641765824998', '$3.03', 85);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (86, '11/16/2023', 86, '8/17/2023', '1/29/2024', 26, '3531498036003513', '$1.65', 86);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (87, '1/13/2024', 87, '12/30/2023', '11/5/2023', 62, '5610425697691764', '$1.07', 87);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (88, '2/13/2024', 88, '11/15/2023', '11/7/2023', 13, '3555114126772708', '$7.94', 88);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (89, '9/15/2023', 89, '12/31/2023', '9/26/2023', 4, '4041593632260219', '$7.82', 89);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (90, '8/21/2023', 90, '4/24/2023', '9/7/2023', 18, '4026081641570256', '$1.22', 90);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (91, '10/15/2023', 91, '8/18/2023', '3/3/2024', 11, '374283763762333', '$2.22', 91);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (92, '8/14/2023', 92, '7/13/2023', '7/8/2023', 64, '5100149350081546', '$1.18', 92);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (93, '4/6/2024', 93, '11/17/2023', '3/4/2024', 66, '3558358397248602', '$0.66', 93);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (94, '10/14/2023', 94, '5/27/2023', '4/1/2024', 51, '5327931741382486', '$8.57', 94);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (95, '12/8/2023', 95, '7/4/2023', '8/7/2023', 74, '5610655755597803756', '$2.63', 95);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (96, '12/28/2023', 96, '7/19/2023', '3/29/2024', 4, '493631480439944412', '$3.86', 96);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (97, '11/29/2023', 97, '12/27/2023', '7/16/2023', 25, '3555481481054364', '$7.29', 97);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (98, '7/7/2023', 98, '3/2/2024', '9/20/2023', 100, '3558148312536789', '$6.05', 98);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (99, '5/25/2023', 99, '12/29/2023', '2/6/2024', 89, '4911249177417832', '$9.72', 99);
insert into [Credits] (Loan_ID, Date, Client_ID, Issue_Date, Closing_Date, Rate, Account, Main_debt, Product_ID) values (100, '7/3/2023', 100, '5/25/2023', '2/8/2024', 40, '201696903363820', '$6.72', 100);

--- 2.Заполняем таблицу [Clients]

SET IDENTITY_INSERT  [Credits]  OFF
SET IDENTITY_INSERT  [Clients]  ON

insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (1, 'Clementius Shakespeare', '10/8/2023', 'Satka');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (2, 'Dolf Laundon', '7/15/2023', 'Lamont');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (3, 'Pearce Stanman', '2/4/2024', 'Marčelji');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (4, 'Meara Moggach', '11/25/2023', 'Calzada Larga');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (5, 'Louisa Moreno', '7/10/2023', 'Antalaha');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (6, 'Phillida Helix', '3/23/2024', 'Fengyang');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (7, 'Dasya Egle of Germany', '10/10/2023', 'Jefferson City');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (8, 'Giffie Kopfen', '9/27/2023', 'Luleå');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (9, 'Shadow Levine', '3/8/2024', 'Hongdun');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (10, 'Whitney Brann', '12/5/2023', 'Oslo');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (11, 'Chandler Fries', '12/9/2023', 'Kaligutan');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (12, 'Mandy Labell', '7/12/2023', 'Tsiroanomandidy');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (13, 'Micky Need', '4/29/2023', 'Tongjiaxi');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (14, 'Karly Assard', '7/8/2023', 'Piúma');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (15, 'Arabella Ugo', '5/14/2023', 'Ban Phue');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (16, 'Luce Copland', '4/8/2024', 'Manhumirim');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (17, 'Bradney Olcot', '8/25/2023', 'Novokhopërsk');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (18, 'Jemima Imort', '5/18/2023', 'Teresa');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (19, 'Rees Glencros', '4/24/2023', 'Kpalimé');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (20, 'Dillon Edgeller', '11/20/2023', 'Curpahuasi');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (21, 'Halley Wolfe', '8/21/2023', 'Kailahun');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (22, 'Boris Menier', '2/9/2024', 'Zawiya');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (23, 'Taddeusz Bernardotti', '3/31/2024', 'Pondokkaha Kelod');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (24, 'Lilyan Elt', '7/4/2023', 'Dulangan');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (25, 'Chariot Gerardet', '8/10/2023', 'Nazir Town');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (26, 'Lawton Iacovino', '4/9/2024', 'Xilian');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (27, 'Ennis Banbrick', '4/4/2024', 'Komorniki');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (28, 'Cristina Lapthorn', '2/26/2024', 'Jönköping');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (29, 'Lyn Bontein', '7/19/2023', 'Carvalhinho');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (30, 'Lucio Ellph', '6/29/2023', 'Besuki Dua');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (31, 'Emylee Velde', '6/8/2023', 'Żoliborz');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (32, 'Haley Puffett', '3/30/2024', 'Walagar');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (33, 'Glyn Bream', '11/17/2023', 'Ūdalah');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (34, 'Nickolai Engel', '5/14/2023', 'Orlando');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (35, 'Corilla Glyne', '2/4/2024', 'Novoye Devyatkino');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (36, 'Merrel Faulkes', '8/13/2023', 'Lihu');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (37, 'Penni Ungaretti', '11/20/2023', 'Banī Walīd');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (38, 'Jarrad Pennicott', '7/10/2023', 'Taywanak Ilaya');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (39, 'Tyler Grigorini', '7/6/2023', 'Klau');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (40, 'Marcia Worsom', '6/8/2023', 'Jatinagara Kulon');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (41, 'Henriette Tebbet', '10/1/2023', 'Lakbok');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (42, 'Rosana Langford', '1/17/2024', 'Batanamang');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (43, 'Berty Yelding', '4/23/2023', 'Västra Frölunda');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (44, 'Jerrylee Cleeve', '11/14/2023', 'Bordeaux');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (45, 'Geoffrey Porritt', '7/12/2023', 'Layo');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (46, 'Alessandra Broseman', '10/10/2023', 'Zhinvali');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (47, 'Theodore Ingilson', '12/24/2023', 'Parang');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (48, 'Adriena Dumbrall', '3/30/2024', 'Velyka Bilozerka');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (49, 'Gates Rhucroft', '10/17/2023', 'Staré Hradiště');
insert into [Clients] (Client_ID, Client_Name, Date_of_birth, Address) values (50, 'Robin Kirgan', '8/26/2023', 'Pagelaran');


--- 3.Заполняем таблицу [Products] вручную

SET IDENTITY_INSERT  [Clients]  OFF
SET IDENTITY_INSERT  [Products]  ON

insert into [Products] ([Product_ID], [Product], [Segment]) values (1, 'Ипотека', 'И');
insert into [Products] ([Product_ID], [Product], [Segment]) values (2, 'Потребительский кредит', 'ПК');
insert into [Products] ([Product_ID], [Product], [Segment]) values (3, 'Кредитные карты', 'КК');
insert into [Products] ([Product_ID], [Product], [Segment]) values (4, 'Автокредит', 'А');
insert into [Products] ([Product_ID], [Product], [Segment]) values (5, 'Микро', 'М');
